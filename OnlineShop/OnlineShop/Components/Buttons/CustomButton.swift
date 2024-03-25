//
//  CustomButton.swift
//  OnlineShop
//
//  Created by Данила on 25.03.2024.
//

import SwiftUI
import ComposableArchitecture

struct CustomButton: View {
    
    let text: String
    var isDisabled: Bool
    
    let storeAuth: StoreOf<AuthFeature>?
    let storeReg: StoreOf<RegistrationFeature>?
    
    var body: some View {
        content(text: text, isDisabled: isDisabled)
    }
}

extension CustomButton {
    @ViewBuilder
    func content(text: String, isDisabled: Bool) -> some View {
        Button {
            registrate()
        } label: {
            VStack {
                Text(text)
                    .foregroundStyle(.white)
                    .bold()
                    .font(.title2)
                    .padding(.vertical, 16)
            }
            .frame(maxWidth: .infinity)
            .background(roundedBackground())
            .padding(.horizontal, 16)
        }
        .disabled(isDisabled)
        .buttonStyle(ScaleButtonStyle())
    }
    
    @ViewBuilder
    func roundedBackground() -> some View {
        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
            .foregroundColor(.black)
    }
}

extension CustomButton {
    func registrate() {
        if let store = storeReg {
            store.send(.buttonTapped)
        }
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.04 : 1)
    }
}


//#Preview {
//    @State var isDisabled: Bool = false
//    CustomButton(text: "Зарегистрироваться", isDisabled: $isDisabled)
//}
