//
//  FavoritePresenter.swift
//  Foody
//
//  Created by mora hakim on 21/12/24.
//

import Foundation
import Combine

class FavoritePresenter: ObservableObject {
    private var favoriteUseCase: FavoriteUseCase
    private var cancellable: Set<AnyCancellable> = []
    
    @Published var restaurants: [RestaurantModel] = []
    @Published var isLoading: Bool = false
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    func getFavoriteRestaurants() {
        self.isLoading = true
        self.favoriteUseCase.getFavorite()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            }, receiveValue: { restaurants in
                self.restaurants = restaurants
            })
            .store(in: &self.cancellable)
    }
}
