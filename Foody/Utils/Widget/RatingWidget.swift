//
//  RatingWidget.swift
//  Foody
//
//  Created by mora hakim on 18/12/24.
//

import SwiftUI

public struct RatingWidget: View {

    var rating: Float = 4.2
    var reviewCount: Int

    public init(rating: Float, reviewCount: Int) {
        self.rating = rating
        self.reviewCount = reviewCount
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                ForEach((1...5), id: \.self) {
                    if $0 <= Int(rating) {
                        Image.icStar
                            .foregroundColor(.yellow)
                    } else {
                        Image.icStar
                            .foregroundColor(.gray)
                    }
                }

                Text(String(format: "%.1f", 4.2))
                    .bold()
                    .descriptionStyle()
            }
            Text("\(reviewCount) " + "review")
                .foregroundColor(.black80)
                .font(.system(size: 14))
        }
    }
}

struct Rating_Previews: PreviewProvider {
    static var previews: some View {
        RatingWidget(rating: 4.2, reviewCount: 4)
    }
}
