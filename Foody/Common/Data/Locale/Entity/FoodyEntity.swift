//
//  FoodyEntity.swift
//  Foody
//
//  Created by mora hakim on 21/12/24.
//

import Foundation
import SwiftData

@Model
class RestaurantEntity {
    @Attribute(.unique) var id: String
    var name: String
    var overview: String
    var mediumPictureUrl: String
    var smallPictureUrl: String
    var city: String
    var rating: Float

    init(id: String, name: String, overview: String, mediumPictureUrl: String, smallPictureUrl: String, city: String, rating: Float) {
        self.id = id
        self.name = name
        self.overview = overview
        self.mediumPictureUrl = mediumPictureUrl
        self.smallPictureUrl = smallPictureUrl
        self.city = city
        self.rating = rating
    }
}

