//
//  HomePresenter.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation
import Combine

class HomePresenter<S: Scheduler>: ObservableObject {
    
    private var cancellable: Set<AnyCancellable> = []
    private let scheduler: S
    private let useCase: HomeUseCase
    
    
    @Published var restaurants: [RestaurantModel] = []
    @Published var keyword: String = ""
    @Published var isLoading: Bool = true
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""
    
    init(scheduler: S, useCase: HomeUseCase) {
        self.scheduler = scheduler
        self.useCase = useCase
        self.setupObservable()
    }
    
    private func setupObservable() {
        self.$keyword
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .dropFirst()
            .sink { self.searchRestaurant(query: $0) }
            .store(in: &self.cancellable)
    }
    
    func searchRestaurant(query: String) {
        self.isLoading = true
        self.useCase.searchRestaurant(query: query)
            .receive(on: self.scheduler)
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            }, receiveValue: { restaurant in
                self.restaurants = restaurant
            })
            .store(in: &self.cancellable)
    }
    
    func getRestaurants() {
        self.useCase.getRestaurants()
            .receive(on: self.scheduler)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.restaurants = []
                    self.errorMessage = "Failed to load data: \(error.localizedDescription)" 
                    self.showErrorAlert = true
                }
            }, receiveValue: { restaurant in
                self.restaurants = restaurant
            })
            .store(in: &self.cancellable)
    }

}
