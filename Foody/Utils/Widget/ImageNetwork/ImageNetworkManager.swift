//
//  ImageNetworkManager.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation

import Combine

class ImageNetworkManager: ObservableObject {
    var data = PassthroughSubject<Data, Never>()

    init(url: String) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let imageData = data else { return }
            DispatchQueue.main.async {
                self.data.send(imageData)
            }
        }

        task.resume()
    }
}
