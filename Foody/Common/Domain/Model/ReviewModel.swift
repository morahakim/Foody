//
//  ReviewModel.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation

public struct ReviewModel: Equatable, Identifiable {
    public var id = UUID()
    public let name: String
    public let review: String
    public let date: String
}
