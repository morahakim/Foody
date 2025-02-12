//
//  ReviewWidget.swift
//  Foody
//
//  Created by mora hakim on 18/12/24.
//

import SwiftUI

public struct ReviewWidget: View {
    let reviewModel: ReviewModel

    public init(reviewModel: ReviewModel) {
        self.reviewModel = reviewModel
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(self.reviewModel.name)
                Spacer()
                Text(self.reviewModel.date)
                    .descriptionStyle()
            }
            Text(self.reviewModel.review)
                .descriptionStyle()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2, x: 0, y: 0)
    }
}

struct ReviewWidget_Previews: PreviewProvider {
    static var previews: some View {
        ReviewWidget(reviewModel: ReviewModel(name: "Ahmad", review: "Tidka rekomendasi untuk pelajar", date: "31 Desember 2015"))
            .previewLayout(.sizeThatFits)
    }
}
