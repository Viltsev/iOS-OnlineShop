//
//  MainView.swift
//  OnlineShop
//
//  Created by Данила on 26.03.2024.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    @Bindable var store: StoreOf<MainFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView(selection: viewStore.binding(get: \.selectedTab, send: MainFeature.Action.tabSelected),
                    content:  {
                SneakersView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Sneakers")
                    }
                    .tag(MainFeature.Tab.sneakers)
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(MainFeature.Tab.profile)
            })
        }
    }
}

//#Preview {
//    MainView()
//}
