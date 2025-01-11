//
//  FoodyApp.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import SwiftUI

@main
struct FoodyApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView(presenter: DependencyManager.shared.makeHomePresenter(),
                         repository: DependencyManager.shared.getRestaurantRepository())
                .tabItem {
                    Image.icHouse
                    Text("home".localized(identifier: ""))
                }
                
                FavoriteView(favoritePresenter: DependencyManager.shared.makeFavoritePresenter(),
                             repository: DependencyManager.shared.getRestaurantRepository())
                    .tabItem {
                        Image.icFavoriteFill
                        Text("favorite".localized(identifier: ""))
                    }
                
                AboutView()
                    .tabItem {
                        Image.icAbout
                        Text("about".localized(identifier: ""))
                    }
            }
           
        }
    }
}
