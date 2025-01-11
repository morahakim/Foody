//
//  FavoriteView.swift
//  Foody
//
//  Created by mora hakim on 21/12/24.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    
    @ObservedObject var  favoritePresenter: FavoritePresenter
    private let router: FavoriteRouter
    
    init(favoritePresenter: FavoritePresenter, repository: RestaurantRepository) {
        self.favoritePresenter = favoritePresenter
        self.router = FavoriteRouter(repository: repository)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Welcome")
                        .descriptionStyle()
                        .bold()

                    Text("Happy meal")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black100)
                }
                
                Spacer()
                    .frame(height: 24)
                
                if self.favoritePresenter.isLoading {
                    HStack {
                        Spacer()
                        VStack {
                            LoadingWidget(isLoading: self.$favoritePresenter.isLoading, style: .large)
                            Text("Loading, please wait")
                        }
                        Spacer()
                    }
                } else {
                    if !self.favoritePresenter.restaurants.isEmpty {
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(self.favoritePresenter.restaurants, id: \.id) { restaurants in
                                NavigationLink(
                                    destination: router.navigateToDetail(for: restaurants.id),
                                    label: {
                                        RestaurantListWidget(restaurantModel: restaurants)
                                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                                    }
                                )
                            }
                        }
                    } else {
                        Text("Yaahh :( \nYou don't have your favorite restaurant yet")
                            .titleStyle()
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
            .onAppear {
                self.favoritePresenter.getFavoriteRestaurants()
            }
        }
    }
}
