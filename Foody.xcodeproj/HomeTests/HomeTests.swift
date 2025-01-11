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

    private var presenter: HomePresenter<DispatchQueue>!
      private var mockUseCase: MockHomeUseCase!
      private var cancellables: Set<AnyCancellable>!
      
      override func setUp() {
          super.setUp()
          self.mockUseCase = MockHomeUseCase()
          self.presenter = HomePresenter(scheduler: DispatchQueue.main, useCase: self.mockUseCase)
          self.cancellables = []
      }
      
      override func tearDown() {
          self.presenter = nil
          self.mockUseCase = nil
          self.cancellables = nil
          super.tearDown()
      }
      
      func testGetFoodsSuccess() {
          // Given: Mock data
          let mockFoods = [
              FoodyModel(id: "1", name: "Pizza", description: "Delicious pizza", pictureId: "img1", city: "New York", rating: 4.5),
              FoodyModel(id: "2", name: "Burger", description: "Tasty burger", pictureId: "img2", city: "Los Angeles", rating: 4.0)
          ]
          self.mockUseCase.mockResult = .success(mockFoods)
          
          // When: Fetching foods
          let expectation = XCTestExpectation(description: "Fetching foods successfully")
          self.presenter.$foods
              .dropFirst() // Skip the initial value
              .sink { foods in
                  XCTAssertEqual(foods, mockFoods, "Foods fetched should match mock data")
                  expectation.fulfill()
              }
              .store(in: &self.cancellables)
          
          self.presenter.getFoods()
          
          // Then: Wait for the expectation
          wait(for: [expectation], timeout: 2.0)
      }
      
      func testGetFoodsFailure() {
          // Given: Mock failure
          self.mockUseCase.mockResult = .failure(NetworkError.invalidResponse)
          
          // When: Fetching foods
          let expectation = XCTestExpectation(description: "Fetching foods failed")
          self.presenter.$foods
              .dropFirst() // Skip the initial value
              .sink { foods in
                  XCTAssertTrue(foods.isEmpty, "Foods should be empty on failure")
                  expectation.fulfill()
              }
              .store(in: &self.cancellables)
          
          self.presenter.getFoods()
          
          // Then: Wait for the expectation
          wait(for: [expectation], timeout: 2.0)
      }

}
