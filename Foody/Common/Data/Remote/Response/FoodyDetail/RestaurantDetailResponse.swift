//
//  FoodyDetailResponse.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation

struct RestaurantDetailResponse: Decodable {
    let error: Bool?
    let message: String?
    let count: Int?
    let restaurant: RestaurantDetailResult
}
