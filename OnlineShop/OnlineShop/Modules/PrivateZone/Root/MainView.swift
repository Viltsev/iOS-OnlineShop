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
                    .setUpTab(.sneakers)
                ProfileView()
                    .setUpTab(.profile)
            })
            
            CustomTabBar(viewStore: viewStore)
        }
    }
    
    @ViewBuilder
    func CustomTabBar(viewStore: ViewStore<MainFeature.State, MainFeature.Action>) -> some View {
        HStack(spacing: 0) {
            ForEach(viewStore.binding(get: \.allTabs, send: MainFeature.Action.allTabsAction)) { $animatedTab in
                let tab = animatedTab.tab
                
                VStack {
                    if viewStore.selectedTab == tab {
                        withAnimation(.bouncy) {
                            Circle()
                                .foregroundStyle(.myGreenLight)
                                .padding(.horizontal, 70)
                                .overlay {
                                    Image(systemName: tab.rawValue)
                                        .font(.title2)
                                        .scaleEffect(viewStore.selectedTab == tab ? 1.25 : 1.0)
                                }
                        }
                    } else {
                        Image(systemName: tab.rawValue)
                            .font(.title2)
                            //.scaleEffect(viewStore.selectedTab == tab ? 1.25 : 1.0)
                    }
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(.myBlackGray)
                .padding(.top, 15)
                .padding(.bottom, 10)
                .contentShape(.rect)
                .onTapGesture {
                    _ = withAnimation(.bouncy) {
                        viewStore.send(MainFeature.Action.tabSelected(tab))
                    }
                }
            }
        }
        .background(.white)
    }
}

extension View {
    @ViewBuilder
    func setUpTab(_ tab: MainFeature.Tab) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
    }
}

//#Preview {
//    MainView()
//}
