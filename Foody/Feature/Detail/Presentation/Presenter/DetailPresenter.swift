//
//  Presenter.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation
import Combine

class DetailPresenter<S: Scheduler>: ObservableObject {

    private var cancellable: Set<AnyCancellable> = []
    private let scheduler: S
    private let detailUseCase: DetailUseCase

    @Published var restaurantDetail: RestaurantDetailModel?
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""

    init(scheduler: S, detailUseCase: DetailUseCase) {
        self.scheduler = scheduler
        self.detailUseCase = detailUseCase
    }

    func getDetailRestaurant(restaurantId: String) {
        self.detailUseCase.getRestaurantDetail(restaurantId: restaurantId)
            .receive(on: self.scheduler)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Failed to load data: \(error.localizedDescription)"
                    self.showErrorAlert = true
                    break
                case .finished:
                    break
                }
            }, receiveValue: { restaurant in
                self.restaurantDetail = restaurant
            })
            .store(in: &self.cancellable)
    }
    
    func addFavorite() {
        guard let restaurant = self.restaurantDetail else { return }
        self.detailUseCase.addFavorite(restaurant: restaurant)
            .receive(on: self.scheduler)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    break
                case .finished:
                    break
                }
            }, receiveValue: { isSuccess in
                self.restaurantDetail?.isFavorite = isSuccess
            })
            .store(in: &self.cancellable)
    }
}
