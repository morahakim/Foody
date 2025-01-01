//
//  FoodyDetailMenu.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation

struct RestaurantDetailMenu: Decodable {
    let foods: [RestaurantDetailItem]?
    let drinks: [RestaurantDetailItem]?
}
