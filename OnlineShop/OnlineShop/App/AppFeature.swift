//
//  AppFeature.swift
//  OnlineShop
//
//  Created by Данила on 22.03.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AppFeature {
    enum State {
        case authorized(MainFeature.State)
        case unauthorized(StartScreenFeature.State)
        
        init() {
            self = .unauthorized(StartScreenFeature.State())
        }
    }
    
    enum Action {
        case authorized(MainFeature.Action)
        case unauthorized(StartScreenFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .unauthorized(.delegate(.authCompleted)):
                state = .authorized(MainFeature.State())
                return .none
            case .unauthorized(.delegate(.regCompleted)):
                state = .authorized(MainFeature.State())
                return .none
            case .unauthorized:
                return .none
            case .authorized:
                return .none
            }
        }
        .ifCaseLet(\.unauthorized, action: \.unauthorized) {
            StartScreenFeature()
        }
        .ifCaseLet(\.authorized, action: \.authorized) {
            MainFeature()
        }
    }
}
