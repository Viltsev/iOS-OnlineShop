//
//  MainView.swift
//  OnlineShop
//
//  Created by Данила on 26.03.2024.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    @Bindable var store: StoreOf<MainFeature>
    
    var body: some View {
        Text("Profile view")
    }
}

//#Preview {
//    MainView()
//}
