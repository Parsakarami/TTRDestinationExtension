//
//  DestinationCompactView.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-26.
//

import Foundation
import SwiftUI

struct DestinationCompactView : View {
    @State var destinations : Destination
    var body: some View {
                    HStack(content: {
                        Text(destinations.origin)
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .frame(width: 80, alignment: .leading)
                        .padding(.leading,10)
                        
                        Label(" - ",
                        systemImage: "")
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .frame(width: 20, alignment: .leading)
                        
                        Label(destinations.destination,
                        systemImage: "")
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .frame(width: 100, alignment: .leading)
                        
                        Label(String(destinations.point),
                        systemImage: "")
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .frame(width: 100, alignment: .center)
                        .foregroundColor(.white)
                    })
                    .frame(width: 320,height: 30, alignment: .leading)
                    .background(.gray)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
    }


