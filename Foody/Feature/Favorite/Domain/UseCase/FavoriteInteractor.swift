//
//  FavoriteInteractor.swift
//  Foody
//
//  Created by mora hakim on 21/12/24.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    func getFavorite() -> AnyPublisher<[RestaurantModel], Error>
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: RestaurantRepository
    
    init(repository: RestaurantRepository) {
        self.repository = repository
    }
    
    func getFavorite() -> AnyPublisher<[RestaurantModel], any Error> {
        return repository.getFavorite()
    }
}
