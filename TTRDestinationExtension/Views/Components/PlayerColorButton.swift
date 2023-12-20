//
//  PlayerColorButton.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-19.
//

import SwiftUI

struct PlayerColorButton: View {
    var isMatch: Bool
    var bgColor: Color
    var body: some View {
            Label("",systemImage: isMatch ? "checkmark" : "")
                .font(.system(size: 25, design: .default))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.leading,8)
                .frame(width: 38, height: 38,alignment: .center)
                .background(bgColor)
                .cornerRadius(5)
    }
}

#Preview {
    PlayerColorButton(isMatch: true,bgColor: .green)
    
}


