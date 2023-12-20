//
//  ColorExtension.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-20.
//

import Foundation
import SwiftUI

extension Color {
    
    init?(byName: String) {
        switch byName {
        case "clear":       self = .clear
        case "black":       self = .black
        case "white":       self = .white
        case "gray":        self = .gray
        case "red":         self = .red
        case "green":       self = .green
        case "blue":        self = .blue
        case "orange":      self = .orange
        case "yellow":      self = .yellow
        case "pink":        self = .pink
        case "purple":      self = .purple
        case "primary":     self = .primary
        case "secondary":   self = .secondary
        default:            return nil
        }
    }
}
