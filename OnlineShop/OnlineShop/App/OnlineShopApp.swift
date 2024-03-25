//
//  OnlineShopApp.swift
//  OnlineShop
//
//  Created by Данила on 22.03.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct OnlineShopApp: App {
    static let store = Store(initialState: StartScreenFeature.State()) {
        StartScreenFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            StartScreenView(store: OnlineShopApp.store)
        }
    }
}
