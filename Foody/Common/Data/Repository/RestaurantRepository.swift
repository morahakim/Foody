//
//  FoodyRepository.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation
import Combine

public protocol RestaurantRepository {
    func getRestaurant() -> AnyPublisher<[RestaurantModel], Error>
    func getRestaurantDetail(restaurantId: String) -> AnyPublisher<RestaurantDetailModel, Error>
    func getFavorite() -> AnyPublisher<[RestaurantModel], Error>
    func addFavorite(restaurant: RestaurantDetailModel) -> AnyPublisher<Bool, Error>
    func searchRestaurant(query: String) -> AnyPublisher<[RestaurantModel], Error>
}

public class RestaurantRepositoryImpl: RestaurantRepository {

    private let localeDataSource: LocaleDataSource
    private let remoteDataSource: RemoteDataSource

    init(remoteDataSource: RemoteDataSource, localeDataSource: LocaleDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localeDataSource = localeDataSource
    }

    public func getRestaurant() -> AnyPublisher<[RestaurantModel], Error> {
        return self.remoteDataSource.getRestaurant()
            .map { $0.mapToModel() }
            .eraseToAnyPublisher()
    }
    
    public func getRestaurantDetail(restaurantId: String) -> AnyPublisher<RestaurantDetailModel, any Error> {
        return Publishers.Zip(self.remoteDataSource.getRestaurantDetail(restaurantId: restaurantId),
                              self.localeDataSource.isFavorite(restaurantId: restaurantId))
        .flatMap { (foodDetailResult, isFavorite) -> AnyPublisher<RestaurantDetailModel, Error> in
            return Future<RestaurantDetailModel, Error> { completion in
                var foodDetail = foodDetailResult.mapToModel()
                foodDetail.isFavorite = isFavorite
                completion(.success(foodDetail))
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()

    }
    
    public func getFavorite() -> AnyPublisher<[RestaurantModel], Error> {
        return self.localeDataSource.getFavorite()
            .map { $0.mapToModel() }
            .eraseToAnyPublisher()
    }

    public func addFavorite(restaurant: RestaurantDetailModel) -> AnyPublisher<Bool, Error> {
        return self.localeDataSource.addFavorite(restaurant: restaurant.mapToEntity())
    }
    
    public func searchRestaurant(query: String) -> AnyPublisher<[RestaurantModel], Error> {
        return self.remoteDataSource.searchRestaurant(query: query)
            .map { $0.mapToModel() }
            .eraseToAnyPublisher()
    }

}
