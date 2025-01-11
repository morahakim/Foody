//
//  DetailUseCase.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation
import Combine

protocol DetailUseCase {
    func getRestaurantDetail(restaurantId: String) -> AnyPublisher<RestaurantDetailModel, Error>
    func addFavorite(restaurant: RestaurantDetailModel) -> AnyPublisher<Bool, Error>
}

class DetailInteractor: DetailUseCase {

    private let repository: RestaurantRepository

    init(repository: RestaurantRepository) {
        self.repository = repository
    }

    func getRestaurantDetail(restaurantId: String) -> AnyPublisher<RestaurantDetailModel, Error> {
        return self.repository.getRestaurantDetail(restaurantId: restaurantId)
    }
    
    func addFavorite(restaurant: RestaurantDetailModel) -> AnyPublisher<Bool, Error> {
        return self.repository.addFavorite(restaurant: restaurant)
    }
}
