//
//  RegistrationFeature.swift
//  OnlineShop
//
//  Created by Данила on 22.03.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RegistrationFeature {
    @ObservableState
    struct State: Equatable {
        var username: String = ""
        var email: String = ""
        var password: String = ""
        var isEnabledRegistration: Bool = true
        @Presents var alert: AlertState<Action.Alert>?
        var registerStatus = "undefined!"
        let newworkClient = NetworkClient()
    }
    
    enum Action {
        case didChangeUsername(String)
        case didChangeEmail(String)
        case didChangePassword(String)
        case enableRegistration
        case checkPassword
        case buttonTapped
        case signUpResponse(Result<Data, Error>)
        case alert(PresentationAction<Alert>)
        case delegate(Delegate)
        
        enum Delegate {
            case registrationCompleted
        }
        
        enum Alert {
            case confirm
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didChangeUsername(let value):
                state.username = value
                return .run { send in
                    await send(.enableRegistration)
                }
            case .didChangeEmail(let value):
                state.email = value
                return .run { send in
                    await send(.enableRegistration)
                }
            case .didChangePassword(let value):
                state.password = value
                return .run { send in
                    await send(.enableRegistration)
                }
            case .enableRegistration:
                if !state.email.isEmpty && !state.password.isEmpty && !state.username.isEmpty {
                    state.isEnabledRegistration = false
                } else {
                    state.isEnabledRegistration = true
                }
                return .none
            case .buttonTapped:
                return .run { send in
                    await send(.checkPassword)
                    
                }
            case .checkPassword:
                let signUpRequest = SignUpRequest(username: state.username, email: state.email, password: state.password)
                
                if state.password.count <= 10 {
                    state.alert = .confirm
                    return .none
                } else {
                    return .run { send in
                        do {
                            let response = try await NetworkClient().signUp(request: signUpRequest)
                            await send(.signUpResponse(.success(response)))
                        } catch {
                            await send(.signUpResponse(.failure(error)))
                        }
                    }
                }
                
            case .signUpResponse(let result):
                switch result {
                case .success(let data):
                    state.registerStatus = "success"
                    print("sign up success: ", data)
                    return .run { send in
                        await send(.delegate(.registrationCompleted))
                        await self.dismiss()
                    }
                case .failure(let error):
                    state.registerStatus = "failure"
                    print("sign up error: ", error)
                    return .none
                }
                
            case .delegate:
                return .none
                
            case .alert:
                return .none
            }
        }
        .ifLet(\.alert, action: \.alert)
    }
}

extension AlertState where Action == RegistrationFeature.Action.Alert {
    static let confirm = Self {
        TextState("Пароль должен состоять более, чем из 10 символов!")
    } actions: {
        ButtonState(role: .cancel, action: .confirm) {
            TextState("Отмена")
        }
    }
}
