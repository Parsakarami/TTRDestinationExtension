//
//  GradientStack.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-24.
//

import SwiftUI

struct GradientStack<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
    
    var body: some View {
        ZStack {
            GradientBackground(topColor: .blue, bottomColor: .black)
            content
        }
    }
}

#Preview {
    GradientStack(content: {})
}
