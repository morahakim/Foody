//
//  DependencyManager.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation
import SwiftData

class DependencyManager {
    
    static let shared = DependencyManager()
    
    private init() {}
    
    private lazy var modelContainer: ModelContainer = {
            return ModelContainer.setup()
        }()
    
    private lazy var remoteDataSource: RemoteDataSource = RemoteDataSourceImpl()
    private lazy var localeDataSource: LocaleDataSource = LocaleDataSourceImpl(modelContainer: modelContainer)
       
    private lazy var restaurantRepository: RestaurantRepository = RestaurantRepositoryImpl(
        remoteDataSource: remoteDataSource, localeDataSource: localeDataSource
       )

    private lazy var homeUseCase: HomeUseCase = HomeInteractor(repository: restaurantRepository)
    private lazy var detailUseCase: DetailUseCase = DetailInteractor(repository: restaurantRepository)
    private lazy var favoriteUseCase: FavoriteUseCase = FavoriteInteractor(repository: restaurantRepository)
    
    
    func makeHomePresenter() -> HomePresenter<RunLoop> {
        return HomePresenter(scheduler: RunLoop.main, useCase: homeUseCase)
    }
    
    func makeDetailPresenter() -> DetailPresenter<RunLoop> {
        return DetailPresenter(scheduler: RunLoop.main, detailUseCase: detailUseCase)
    }
    
    func makeFavoritePresenter() -> FavoritePresenter {
        return FavoritePresenter(favoriteUseCase: favoriteUseCase)
    }
    
    func getRestaurantRepository() -> RestaurantRepository {
           return restaurantRepository
       }
}
