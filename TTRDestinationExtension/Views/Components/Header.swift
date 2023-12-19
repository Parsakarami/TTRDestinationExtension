//
//  Header.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-19.
//

import SwiftUI

struct Header: View {
    var body: some View {
        VStack(content: {
            Label("Ticket to Ride", systemImage: "")
                .font(.system(size: 35, weight: .bold, design: .default))
                .frame(alignment: .center)
                .foregroundColor(.white)
            Label("Destination extension", systemImage: "train.side.front.car")
                .font(.system(size: 18, weight: .medium, design: .default))
                .frame(alignment: .center)
                .foregroundColor(.white)
        }).frame(width: UIScreen.main.bounds.width)
    }
}

#Preview {
    Header()
}
