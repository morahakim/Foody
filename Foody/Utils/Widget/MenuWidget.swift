//
//  MenuWidget.swift
//  Foody
//
//  Created by mora hakim on 18/12/24.
//

import SwiftUI

public struct MenuWidget: View {

    var name: String

    public init(name: String) {
        self.name = name
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(self.name)
                .frame(maxWidth: .infinity)
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2, x: 0, y: 0)
    }
}

struct MenuWidget_Previews: PreviewProvider {
    static var previews: some View {
        MenuWidget(name: "Coffee")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
