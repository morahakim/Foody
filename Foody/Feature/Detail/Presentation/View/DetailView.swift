//
//  DetailView.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var detailPresenter: DetailPresenter<RunLoop>

    var restaurantId: String

    public init(presenter: DetailPresenter<RunLoop>, restaurantId: String) {
        self.detailPresenter = presenter
        self.restaurantId = restaurantId
    }

    private var gridItemLayout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private func addFavorite() {
        self.detailPresenter.addFavorite()
    }
    
    private func isFavorite() -> Bool {
        guard let isFavorite = self.detailPresenter.restaurantDetail?.isFavorite  else { return false}
        return isFavorite
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .topLeading) {
                    ImageNetwork(url: self.detailPresenter.restaurantDetail?.mediumPicture ?? "", width: nil, height: 200)

                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        ZStack {
                            Image.icBack
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.black100)
                        }
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                    })
                    .padding(16)
                    .offset(x: 0)
                }

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(self.detailPresenter.restaurantDetail?.name ?? "")
                        .titleStyle()
                        Spacer()
                        Button(action: self.addFavorite, label: {
                            if self.isFavorite() {
                                Image.icFavoriteFill
                                    .foregroundColor(.red)
                            } else {
                                Image.icFavorite
                                    .foregroundColor(.black60)
                            }
                        })
                    }

                    Text(self.detailPresenter.restaurantDetail?.categories ?? "")
                        .foregroundColor(.black100)
                        .font(.system(size: 14))
                        .italic()

                    HStack {
                        Image.icMap
                            .foregroundColor(.black100)
                        Text("\(self.detailPresenter.restaurantDetail?.address ?? ""), \(self.detailPresenter.restaurantDetail?.city ?? "")")
                            .foregroundColor(.black100)
                            .font(.system(size: 14))
                    }

                    Spacer()
                        .frame(height: 16)

                    VStack(alignment: .leading, spacing: 24) {

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Overview")
                                .titleSectionStyle()

                            Text(self.detailPresenter.restaurantDetail?.description ?? "")
                                .descriptionStyle()
                                .lineLimit(20)
                        }

                        VStack(alignment: .leading, spacing: 16) {
                            Text("Food")
                                .titleSectionStyle()

                            LazyVGrid(columns: gridItemLayout, spacing: 16) {
                                ForEach(self.detailPresenter.restaurantDetail?.foods ?? [], id: \.self) { food in
                                    MenuWidget(name: food)
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 16) {
                            Text("Beverage")
                                .titleSectionStyle()

                            LazyVGrid(columns: gridItemLayout, spacing: 16) {
                                ForEach(self.detailPresenter.restaurantDetail?.drinks ?? [], id: \.self) { drink in
                                    MenuWidget(name: drink)
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Rating")
                                .titleSectionStyle()

                            HStack(spacing: 16) {
                                RatingWidget(
                                    rating: self.detailPresenter.restaurantDetail?.rating ?? 0,
                                    reviewCount: self.detailPresenter.restaurantDetail?.reviews.count ?? 0)
                            }

                            Spacer()
                                .frame(height: 4)

                            ForEach(self.detailPresenter.restaurantDetail?.reviews ?? [], id: \.id) { review in
                                ReviewWidget(reviewModel: review)
                            }
                        }
                    }

                }
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))

                Spacer()
            }
        }
        .navigationBarHidden(true)
        .onAppear(perform: {
            self.detailPresenter.getDetailRestaurant(restaurantId: self.restaurantId)
        })
        .alert(isPresented: $detailPresenter.showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(detailPresenter.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }

    }
}

