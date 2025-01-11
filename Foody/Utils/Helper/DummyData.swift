//
//  FakerData.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation

class DummyData {
    static func getRestaurants() -> RestaurantModel {
        let restaurant: RestaurantModel = RestaurantModel(id: "rqdv5juczeskfw1e867",
                                                          name: "Ramen soya",
                                                          description: "Lorem ipsum dolor sit amet",
                                                          smallPicture: "https://restaurant-api.dicoding.dev/images/small/14",
                                                          mediumPicture: "https://restaurant-api.dicoding.dev/images/medium/14",
                                                          city: "Jakarta",
                                                          rating: 4.2)
        return restaurant
    }
}
