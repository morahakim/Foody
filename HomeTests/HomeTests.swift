//
//  HomeTests.swift
//  HomeTests
//
//  Created by mora hakim on 23/12/24.
//

import Testing
import XCTest
import Combine
@testable import Foody

struct HomeTests {

    @Test
        func testGetFoodsSuccess() async throws {
            let mockUseCase = MockHomeUseCase()
            let presenter = HomePresenter(scheduler: DispatchQueue.main, useCase: mockUseCase)
            
            let mockFoods = [
                RestaurantModel(id: "1", name: "Pizza", description: "Delicious pizza", smallPicture: "img1", mediumPicture: "img2", city: "New york", rating: 4.5),
                RestaurantModel(id: "2", name: "Burger", description: "Delicious burger", smallPicture: "img3", mediumPicture: "img5", city: "New rok", rating: 4.6)
            ]
            mockUseCase.mockResult = .success(mockFoods)
            
            presenter.getRestaurants()
            
            XCTAssertEqual(presenter.restaurants.count, mockFoods.count, "The number of foods should match the mock data")
            XCTAssertEqual(presenter.restaurants, mockFoods, "The fetched foods should match the mock data")
            XCTAssertFalse(presenter.isLoading, "Loading state should be false after data is fetched")

        }
        
    @Test
    func testGetFoodsFailure() async throws {
        let mockUseCase = MockHomeUseCase()
        let presenter = HomePresenter(scheduler: DispatchQueue.main, useCase: mockUseCase)
        
        mockUseCase.mockResult = .failure(NetworkError.invalidResponse)
        
        presenter.getRestaurants()
        
        XCTAssertTrue(presenter.restaurants.isEmpty, "Foods array should be empty when fetching fails")
        XCTAssertFalse(presenter.isLoading, "Loading state should be false after a failure")
    }


}

final class MockHomeUseCase: HomeUseCase {
    var mockResult: Result<[RestaurantModel], Error> = .success([])
    var mockSearchResult: Result<[RestaurantModel], Error> = .success([])

    func getRestaurants() -> AnyPublisher<[RestaurantModel], Error> {
        return Future { completion in
            completion(self.mockResult)
        }
        .eraseToAnyPublisher()
    }
    
    func searchRestaurant(query: String) -> AnyPublisher<[RestaurantModel], Error> {
        return Future { completion in
            completion(self.mockSearchResult) 
        }
        .eraseToAnyPublisher()
    }
}
