//
//  ProfileFeature.swift
//  OnlineShop
//
//  Created by Данила on 01.04.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ProfileFeature {
    @ObservableState
    struct State: Equatable {
        var username: String = "@viltsev"
        var email: String = "d.viltsev@gmail.com"
    }
    
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> { 
        Reduce { state, action in
            switch action {
                
            }
        }
    }
}
