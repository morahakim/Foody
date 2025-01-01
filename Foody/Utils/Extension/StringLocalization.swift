//
//  StringLocalization.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation

public extension String {
    func localized(identifier: String) -> String {
        let bundle = Bundle(identifier: identifier) ?? .main
        return bundle.localizedString(forKey: self, value: nil, table: nil)
    }
}
