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
        // todo: case authorized()
        case unauthorized(StartScreenFeature.State)
        
        init() {
            self = .unauthorized(StartScreenFeature.State())
        }
    }
    
    enum Action {
        // todo: case authorized()
        case unauthorized(StartScreenFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .unauthorized:
                return .none
            }
        }
        .ifLet(\.unauthorized, action: \.unauthorized) {
            StartScreenFeature()
        }
    }
}
