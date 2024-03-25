//
//  StartScreenView.swift
//  OnlineShop
//
//  Created by Данила on 22.03.2024.
//

import SwiftUI
import ComposableArchitecture

struct StartScreenView: View {
    @Bindable var store: StoreOf<StartScreenFeature>
    
    var body: some View {
        VStack(spacing: 25) {
            Button {
                store.send(.registrationButtonTapped)
            } label: {
                Text("Регистрация")
                    .font(.title)
                    .foregroundStyle(.black)
                    .monospaced()
            }
            Button {
                store.send(.authButtonTapped)
            } label: {
                Text("Авторизация")
                    .font(.title)
                    .foregroundStyle(.black)
                    .monospaced()
            }
        }
        .sheet(store: self.store.scope(state: \.$destination.registration,
                                       action: \.destination.registration)) { store in
            RegistrationView(store: store)
        }
        .sheet(store: self.store.scope(state: \.$destination.authorization,
                                      action: \.destination.authorization)) { store in
            AuthView(store: store)
        }
        
    }
}

#Preview {
    StartScreenView(
        store: Store(
            initialState: StartScreenFeature.State()
        ) {
            StartScreenFeature()
        }
    )
}
