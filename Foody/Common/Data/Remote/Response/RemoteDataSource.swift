//
//  RemoteDataSource.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation
import Combine
import Alamofire

protocol RemoteDataSource {
    func getRestaurant() -> AnyPublisher<[RestaurantListDetailResponse], Error>
    func searchRestaurant(query: String) -> AnyPublisher<[RestaurantListDetailResponse], Error>
    func getRestaurantDetail(restaurantId: String) -> AnyPublisher<RestaurantDetailResult, Error>}

class RemoteDataSourceImpl: RemoteDataSource {

    private let baseUrl: String = "https://restaurant-api.dicoding.dev"

    func getRestaurant() -> AnyPublisher<[RestaurantListDetailResponse], Error> {
        return Future<[RestaurantListDetailResponse], Error> { completion in
            if let url = URL(string: "\(self.baseUrl)/list") {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: RestaurantListResultResponse.self) { response in
                        debugPrint(response)
                        switch response.result {
                        case .success(let value):
                            if let restaurants = value.restaurants {
                                completion(.success(restaurants))
                            } else {
                                completion(.failure(NetworkError.empty))
                            }
                        case .failure:
                            completion(.failure(NetworkError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getRestaurantDetail(restaurantId: String) -> AnyPublisher<RestaurantDetailResult, Error> {
        return Future<RestaurantDetailResult, Error> { completion in
            if let url = URL(string: "\(self.baseUrl)/detail/\(restaurantId)") {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: RestaurantDetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.restaurant))
                        case .failure:
                            completion(.failure(NetworkError.empty))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func searchRestaurant(query: String) -> AnyPublisher<[RestaurantListDetailResponse], Error> {
        return Future<[RestaurantListDetailResponse], Error> { completion in
            if let url = URL(string: "\(self.baseUrl)/search?q=\(query)") {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: RestaurantListResultResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            if let restaurants = value.restaurants {
                                completion(.success(restaurants))
                            } else {
                                completion(.failure(NetworkError.empty))
                            }
                        case .failure:
                            completion(.failure(NetworkError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
