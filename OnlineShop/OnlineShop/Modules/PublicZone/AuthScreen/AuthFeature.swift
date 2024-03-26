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
        var username: String = ""
        var password: String = ""
        var isEnabledAuthorization: Bool = true
        var authStatus = "undefined!"
    }
    
    enum Action {
        case didChangeUsername(String)
        case didChangePassword(String)
        case enableAuthorization
        case buttonTapped
        case signInResponse(Result<Data, Error>)
        case delegate(Delegate)
        
        enum Delegate {
            case authorizationCompleted
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didChangeUsername(let email):
                state.username = email
                return .run { send in
                    await send(.enableAuthorization)
                }
            case .didChangePassword(let password):
                state.password = password
                return .run { send in
                    await send(.enableAuthorization)
                }
            case .enableAuthorization:
                if !state.username.isEmpty && !state.password.isEmpty {
                    state.isEnabledAuthorization = false
                } else {
                    state.isEnabledAuthorization = true
                }
                return .none
                
            case .buttonTapped:
                let signInRequest = SignInRequest(username: state.username, password: state.password)
                return .run { send in
                    do {
                        let response = try await NetworkClient().signIn(request: signInRequest)
                        await send(.signInResponse(.success(response)))
                    } catch {
                        await send(.signInResponse(.failure(error)))
                    }
                }
                
            case .signInResponse(let result):
                switch result {
                case .success(let data):
                    state.authStatus = "success"
                    print("sign in success: ", data)
                    return .run { send in
                        await send(.delegate(.authorizationCompleted))
                        await self.dismiss()
                    }
                    
                case .failure(let error):
                    state.authStatus = "failure"
                    print("sign in error: ", error)
                    return .none
                }

            case .delegate:
                return .none
            }
        }
    }
}
