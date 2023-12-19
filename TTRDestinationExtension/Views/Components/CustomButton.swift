//
//  CustomButton.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-17.
//

import SwiftUI

struct CustomButton : View {
    var text: String
    var systemImage: String
    var function : () -> Void = {}
    var backColor: Color = .white
    var foreColor: Color = .blue
    var body: some View {
        Button(action: function) {
            Label(text, systemImage: systemImage).foregroundColor(foreColor)
        }
        .frame(width: 200,height: 30)
        .padding(10)
        .background(backColor)
        .cornerRadius(4.5)
    }
}
