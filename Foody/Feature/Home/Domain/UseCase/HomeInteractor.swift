//
//  HomeUseCase.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getRestaurants() -> AnyPublisher<[RestaurantModel], Error>
    func searchRestaurant(query: String) -> AnyPublisher<[RestaurantModel], Error>
}

class HomeInteractor: HomeUseCase {

    private let repository: RestaurantRepository

    init(repository: RestaurantRepository) {
        self.repository = repository
    }

    func getRestaurants() -> AnyPublisher<[RestaurantModel], Error> {
        return repository.getRestaurant()
    }
    
    func searchRestaurant(query: String) -> AnyPublisher<[RestaurantModel], any Error> {
        return repository.searchRestaurant(query: query)
    }
}
