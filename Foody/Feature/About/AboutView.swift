//
//  AboutView.swift
//  Foody
//
//  Created by mora hakim on 21/12/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 16) {
                    Image("Mora")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.blue)
                        .clipShape(Circle())
                    
                   
                    Text("Mora Hakim")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                  
                    Text("morahakim22@gmail.com")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) 
                .background(Color(.systemBackground))
    }
}

#Preview {
    AboutView()
}
