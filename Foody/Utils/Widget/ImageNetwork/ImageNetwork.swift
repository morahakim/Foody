//
//  ImageNetwork.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import Foundation
import SwiftUI

public struct ImageNetwork: View {

    @ObservedObject var imageManager: ImageNetworkManager
    @State var image: UIImage = UIImage()

    var width: CGFloat?
    var height: CGFloat?

    public init(url: String, width: CGFloat?, height: CGFloat?) {
        self.imageManager = ImageNetworkManager(url: url)
        self.width = width
        self.height = height
    }

    public var body: some View {
        Image(uiImage: self.image)
            .resizable()
            .scaledToFill()
            .frame(width: self.width, height: self.height)
            .clipped()
            .onReceive(imageManager.data) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
    }
}
