//
//  AuthFeature.swift
//  OnlineShop
//
//  Created by Данила on 25.03.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AuthFeature {
    @ObservableState
    struct State: Equatable {
        var email: String = ""
        var password: String = ""
        var isEnabledAuthorization: Bool = true
    }
    
    enum Action {
        case didChangeEmail(String)
        case didChangePassword(String)
        case enableAuthorization
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didChangeEmail(let email):
                state.email = email
                return .run { send in
                    await send(.enableAuthorization)
                }
            case .didChangePassword(let password):
                state.password = password
                return .run { send in
                    await send(.enableAuthorization)
                }
            case .enableAuthorization:
                if !state.email.isEmpty && !state.password.isEmpty {
                    state.isEnabledAuthorization = false
                } else {
                    state.isEnabledAuthorization = true
                }
                return .none
            }
        }
    }
}
