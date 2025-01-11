//
//  FoodyListResultResponse.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation

struct RestaurantListResultResponse: Decodable {

    let error: Bool?
    let message: String?
    let count: Int?
    let restaurants: [RestaurantListDetailResponse]?
}
