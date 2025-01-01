//
//  FoodyListDetailResponse.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation

struct RestaurantListDetailResponse: Decodable {
    let id: String?
    let name: String?
    let description: String?
    let pictureId: String?
    let city: String?
    let rating: Float?
}
