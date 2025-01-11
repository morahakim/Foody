//
//  LocalDataSource.swift
//  Foody
//
//  Created by mora hakim on 21/12/24.
//

import Foundation
import Combine
import SwiftData

protocol LocaleDataSource {
    func getFavorite() -> AnyPublisher<[RestaurantEntity], Error>
    func addFavorite(restaurant: RestaurantEntity) -> AnyPublisher<Bool, Error>
    func isFavorite(restaurantId: String) -> AnyPublisher<Bool, Error>
}

class LocaleDataSourceImpl: @preconcurrency LocaleDataSource {
    private let modelContainer: ModelContainer

    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    @MainActor
    func getFavorite() -> AnyPublisher<[RestaurantEntity], Error> {
        return Future<[RestaurantEntity], Error> { completion in
            let fetchRequest = FetchDescriptor<RestaurantEntity>(
                sortBy: [SortDescriptor(\.name, order: .forward)]
            )
            do {
                let restaurant = try self.modelContainer.mainContext.fetch(fetchRequest)
                completion(.success(restaurant))
            } catch {
                completion(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func addFavorite(restaurant: RestaurantEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            Task { @MainActor in
                do {
                    let restaurantId = restaurant.id
                    
                    let fetchRequest = FetchDescriptor<RestaurantEntity>(
                        predicate: #Predicate { entity in
                            entity.id == restaurantId
                        }
                    )
                    let existingEntities = try self.modelContainer.mainContext.fetch(fetchRequest)
                    
                    if let existingEntity = existingEntities.first {
                        self.modelContainer.mainContext.delete(existingEntity)
                        completion(.success(false))
                    } else {
                        self.modelContainer.mainContext.insert(restaurant)
                        completion(.success(true))
                    }
                    
                    try self.modelContainer.mainContext.save()
                } catch {
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }


    
    func isFavorite(restaurantId: String) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            Task { @MainActor in
                do {
                    let fetchRequest = FetchDescriptor<RestaurantEntity>(
                        predicate: #Predicate { $0.id == restaurantId }
                    )
                    let result = try self.modelContainer.mainContext.fetch(fetchRequest)
                    
                    completion(.success(!result.isEmpty))
                } catch {
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }


}

extension ModelContainer {
    static func setup() -> ModelContainer {
        do {
            let container = try ModelContainer(for: RestaurantEntity.self)
            return container
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
}
