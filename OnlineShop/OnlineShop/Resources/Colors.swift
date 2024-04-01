//
//  Colors.swift
//  OnlineShop
//
//  Created by Данила on 01.04.2024.
//

import Foundation
import UIKit
import SwiftUI


extension Color {
    enum Name: String {
        case lightPink
    }
}

extension Color.Name {
    var path: String { "\(rawValue)" }
}

extension Color {
    init(_ name: Color.Name) {
        self.init(name.path)
    }
}
