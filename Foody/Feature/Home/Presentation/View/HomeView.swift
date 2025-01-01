//
//  ContentView.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter<RunLoop>
    private let router: HomeRouter

    init(presenter: HomePresenter<RunLoop>, repository: RestaurantRepository) {
           self.presenter = presenter
           self.router = HomeRouter(repository: repository)
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
                    .frame(height: 16)

                HStack(spacing: 16) {
                    Image.icSearch
                        .foregroundColor(.black)

                    TextField("Search Restaurant", text: self.$presenter.keyword)
                }
                .frame(maxWidth: .infinity)
                .padding(16)
                .background(Color.black10)
                .cornerRadius(8)

                Spacer()
                    .frame(height: 24)

                if self.presenter.isLoading {
                    HStack {
                        Spacer()
                        VStack {
                            LoadingWidget(isLoading: self.$presenter.isLoading, style: .large)
                            Text("Loading, please wait")
                        }
                        Spacer()
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(self.presenter.restaurants, id: \.id) { restaurants in
                            NavigationLink(
                                destination: router.navigateToDetail(for: restaurants.id),
                                label: {
                                    RestaurantListWidget(restaurantModel: restaurants)
                                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                                }
                            )
                        }
                    }
                }
                Spacer()
            }
            .navigationBarHidden(true)
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
            .onAppear {
                self.presenter.getRestaurants()
            }
            .alert(isPresented: $presenter.showErrorAlert) { 
                Alert(
                    title: Text("Error"),
                    message: Text(presenter.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

