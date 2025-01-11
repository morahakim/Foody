//
//  NetworkError.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation

public enum NetworkError: LocalizedError {
    case invalidResponse
    case empty

    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response"
        case .empty:
            return "Result is empty"
        }
    }
}
