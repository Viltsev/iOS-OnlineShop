//
//  AuthView.swift
//  OnlineShop
//
//  Created by Данила on 25.03.2024.
//

import SwiftUI
import ComposableArchitecture

struct AuthView: View {
    @Bindable var store: StoreOf<AuthFeature>
    
    var body: some View {
        Color.white
            .ignoresSafeArea()
            .overlay {
                content()
            }
    }
}

extension AuthView {
    @ViewBuilder
    func content() -> some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("Авторизация")
                    .font(.largeTitle)
                    .bold()
                    .padding(.vertical, 25)
                    .monospaced()
                Spacer()
                VStack(spacing: 16) {
                    CustomTextField(textFieldLabel: "Username...", text: viewStore.binding(get: \.username, send: { .didChangeUsername($0) }))
                    CustomTextField(textFieldLabel: "Password...", text: viewStore.binding(get: \.password, send: { .didChangePassword($0) }))
                }
                CustomButton(text: "Войти в аккаунт", isDisabled: viewStore.isEnabledAuthorization, storeAuth: store, storeReg: nil)
                    .padding(.vertical, 20)
                Text(viewStore.authStatus)
                    .foregroundStyle(.red)
                    .padding(.vertical, 16)
                Spacer()
            }
        }
    }
}

//#Preview {
//    AuthView()
//}
