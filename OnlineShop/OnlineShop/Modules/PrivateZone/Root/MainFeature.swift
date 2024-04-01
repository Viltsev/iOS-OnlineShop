//
//  MainFeature.swift
//  OnlineShop
//
//  Created by Данила on 26.03.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MainFeature {
    
    @ObservableState
    struct State: Equatable {
        var selectedTab = Tab.sneakers
        var sneakersState = SneakersFeature.State()
        var profileState = ProfileFeature.State()
        var allTabs: [AnimatedTab] = Tab.allCases.compactMap { tab -> AnimatedTab in
            return .init(tab: tab)
        }
    }
    
    enum Action {
        case tabSelected(Tab)
        case sneakersAction(SneakersFeature.Action)
        case profileAction(ProfileFeature.Action)
        case allTabsAction
    }
    
    enum Tab: String, CaseIterable, Equatable {
        case sneakers = "house.fill"
        // case favorites = "book.fill"
        case profile = "person.fill"
        
        var title: String {
            switch self {
            case .sneakers:
                return "Sneakers"
//            case .favorites:
//                return "Favorites"
            case .profile:
                return "Profile"
            }
        }
    }
    
    struct AnimatedTab: Identifiable, Equatable {
        var id: UUID = .init()
        var tab: Tab
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            case .sneakersAction:
                return .none
            case .profileAction:
                return .none
            case .allTabsAction:
                return .none
            }
        }
        
        Scope(state: \.sneakersState, action: /MainFeature.Action.sneakersAction) {
            SneakersFeature()
        }
        
        Scope(state: \.profileState, action: /MainFeature.Action.profileAction) {
            ProfileFeature()
        }
    }
}
