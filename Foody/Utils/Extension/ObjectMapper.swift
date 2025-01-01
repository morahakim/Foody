//
//  ObjectMapper.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation

extension Array where Element == RestaurantListDetailResponse {
    func mapToModel() -> [RestaurantModel] {
        self.map { (result) in
            return RestaurantModel(id: result.id ?? "",
                                   name: result.name ?? "",
                                   description: result.description ?? "",
                                   smallPicture: "https://restaurant-api.dicoding.dev/images/small/\(result.pictureId ?? "")",
                                   mediumPicture: "https://restaurant-api.dicoding.dev/images/medium/\(result.pictureId ?? "")",
                                   city: result.city ?? "",
                                   rating: result.rating ?? 0)
        }
    }
}

extension Array where Element == RestaurantEntity {
    func mapToModel() -> [RestaurantModel] {
        self.map { result in
            return RestaurantModel(id: result.id,
                              name: result.name,
                              description: result.overview,
                              smallPicture: result.smallPictureUrl,
                              mediumPicture: result.mediumPictureUrl,
                              city: result.city,
                              rating: result.rating
            )
        }
    }
}

extension RestaurantDetailResult {
    func mapToModel() -> RestaurantDetailModel {
        var formattedCategory: String = ""
        if let foodCategory = self.categories {
            let category: [String] = foodCategory.map { ($0.name ?? "") }
            formattedCategory = category.joined(separator: ", ")
        }

        var reviewModel: [ReviewModel] = []
        if let foodReviews = self.reviews {
            reviewModel = foodReviews.map { ReviewModel(name: $0.name ?? "", review: $0.review ?? "", date: $0.date ?? "") }
        }

        return RestaurantDetailModel(id: self.id ?? "",
                                     name: self.name ?? "",
                                     description: self.description ?? "",
                                     city: self.city ?? "",
                                     address: self.address ?? "",
                                     smallPicture: "https://restaurant-api.dicoding.dev/images/small/\(self.pictureId ?? "")",
                                     mediumPicture: "https://restaurant-api.dicoding.dev/images/medium/\(self.pictureId ?? "")",
                                     categories: formattedCategory,
                                     foods: (self.menus?.foods?.map { $0.name ?? "" } ?? []),
                                     drinks: (self.menus?.drinks?.map { $0.name ?? "" } ?? []),
                                     rating: self.rating ?? 0,
                                     reviews: reviewModel,
                                     isFavorite: false
        )
    }
}

extension RestaurantDetailModel {
    func mapToEntity() -> RestaurantEntity {
        return RestaurantEntity(id: self.id, name: self.name, overview: self.description, mediumPictureUrl: self.mediumPicture, smallPictureUrl: self.smallPicture, city: self.city, rating: self.rating)
    }
}
