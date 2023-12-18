//
//  GradientBackground.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-17.
//

import SwiftUI

struct GradientBackground: View {
    var topColor: Color
    var bottomColor: Color
    var body: some View {
        LinearGradient(gradient: Gradient(colors:[topColor,bottomColor]),
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
}
