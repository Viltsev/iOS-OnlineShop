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
    let store = Store(initialState: AppFeature.State()) {
        AppFeature()
           // ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            SwitchStore(self.store) { initialState in
                switch initialState {
                case .authorized:
                    CaseLet(\AppFeature.State.authorized, action: AppFeature.Action.authorized) { store in
                        MainView(store: store)
                    }
                case .unauthorized:
                    CaseLet(\AppFeature.State.unauthorized, action: AppFeature.Action.unauthorized) { store in
                        StartScreenView(store: store)
                    }
                }
            }
        }
    }
}
