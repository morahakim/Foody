//
//  FavouriteRouter.swift
//  Foody
//
//  Created by mora hakim on 21/12/24.
//

import SwiftUI
import Combine

class FavoriteRouter {
    
    private let repository: RestaurantRepository
    
    init(repository: RestaurantRepository) {
        self.repository = repository
    }
    
    func navigateToDetail(for restaurantId: String, scheduler: RunLoop = .main) -> some View {
        let detailUseCase = DetailInteractor(repository: repository)
        let presenter = DetailPresenter(scheduler: scheduler, detailUseCase: detailUseCase)
        let detailView = DetailView(presenter: presenter, restaurantId: restaurantId)
        return detailView
    }
    
}
