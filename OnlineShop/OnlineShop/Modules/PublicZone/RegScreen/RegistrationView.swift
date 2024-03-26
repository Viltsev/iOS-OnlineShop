//
//  RegistrationView.swift
//  OnlineShop
//
//  Created by Данила on 22.03.2024.
//

import SwiftUI
import ComposableArchitecture

struct RegistrationView: View {
    
    @Bindable var store: StoreOf<RegistrationFeature>
    
    var body: some View {
        Color.white
            .ignoresSafeArea()
            .overlay {
                content()
            }
    }
    
    
}

extension RegistrationView {
    @ViewBuilder
    func content() -> some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("Регистрация")
                    .font(.largeTitle)
                    .bold()
                    .padding(.vertical, 25)
                    .monospaced()
                Spacer()
                VStack(spacing: 16) {
                    CustomTextField(textFieldLabel: "Username...", text: viewStore.binding(get: \.username, send: { .didChangeUsername($0) }))
                    CustomTextField(textFieldLabel: "Email...", text: viewStore.binding(get: \.email, send: { .didChangeEmail($0) }))
                    CustomTextField(textFieldLabel: "Password...", text: viewStore.binding(get: \.password, send: { .didChangePassword($0) }))
                }
                CustomButton(text: "Зарегистрироваться", isDisabled: viewStore.isEnabledRegistration, storeAuth: nil, storeReg: store)
                    .padding(.vertical, 20)
                Text(viewStore.registerStatus)
                    .foregroundStyle(.red)
                    .padding(.vertical, 16)
                Spacer()
            }
            .alert($store.scope(state: \.alert, action: \.alert))
        }
    }
}

//#Preview {
//    RegistrationView()
//}
