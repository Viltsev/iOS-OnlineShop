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
    }
    
    enum Action {
        case tabSelected(Tab)
        case sneakersAction(SneakersFeature.Action)
        case profileAction(ProfileFeature.Action)
    }
    
    enum Tab {
        case sneakers
        case favorites
        case profile
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
