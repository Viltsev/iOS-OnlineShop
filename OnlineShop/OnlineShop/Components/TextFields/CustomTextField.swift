//
//  CustomTextField.swift
//  OnlineShop
//
//  Created by Данила on 25.03.2024.
//

import SwiftUI

struct CustomTextField: View {
    var textFieldLabel: String
    var text: Binding<String>
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(textFieldLabel, text: text)
                .foregroundColor(.black)
                .font(.headline)
        }
        .underlineTextField()
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay {
                Rectangle()
                    .frame(height: 1)
                    .padding(.top, 35)
                    .foregroundColor(.black)
            }
    }
}
