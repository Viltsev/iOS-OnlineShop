//
//  StartScreenFeature.swift
//  OnlineShop
//
//  Created by Данила on 22.03.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct StartScreenFeature {
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
    }
    
    enum Action {
        case registrationButtonTapped
        case authButtonTapped
        case destination(PresentationAction<Destination.Action>)
        case authCompleted(AuthFeature.Action)
        case delegate(Delegate)
        
        enum Delegate {
            case authCompleted
            case regCompleted
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .registrationButtonTapped:
                state.destination = .registration(RegistrationFeature.State())
                return .none
            case .authButtonTapped:
                state.destination = .authorization(AuthFeature.State())
                return .none
            case .destination(.presented(.authorization(.delegate(.authorizationCompleted)))):
                return .send(.delegate(.authCompleted))
            case .destination(.presented(.registration(.delegate(.registrationCompleted)))):
                return .send(.delegate(.regCompleted))
            case .destination:
                return .none
            case .authCompleted(.delegate(.authorizationCompleted)):
                return .send(.delegate(.authCompleted))
            case .authCompleted:
                return .none
            case .delegate:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination()
        }
    }
}

extension StartScreenFeature {
    @Reducer
    struct Destination {
        enum State: Equatable {
            case registration(RegistrationFeature.State)
            case authorization(AuthFeature.State)
        }
        
        enum Action {
            case registration(RegistrationFeature.Action)
            case authorization(AuthFeature.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.registration, action: \.registration) {
                RegistrationFeature()
            }
            Scope(state: \.authorization, action: \.authorization) {
                AuthFeature()
            }
        }
    }
}


//    struct State: Equatable {
//        @Presents var destination: Destination.State?
//    }
//    enum Action {
//        case destination(PresentationAction<Destination.Action>)
//    }
//    var body: some ReducerOf<Self> {
//        Reduce { state, action in
//            switch action {
//            case .destination:
//                return .none
//            }
//        }
//    }

//extension StartScreenFeature {
//    @Reducer(state: .equatable)
//    enum Destination {
//        case authorization
//        case registration
//    }
//}
