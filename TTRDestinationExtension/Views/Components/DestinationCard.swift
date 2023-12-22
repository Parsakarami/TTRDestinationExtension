//
//  DestinationCard.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-21.
//

import SwiftUI

struct DestinationCard: View {
    var destination: Destination
    @Binding var isSelected : Bool
    var body: some View {
        HStack(content: {
            HStack(content: {
                Text(destination.origin)
                    .padding(2)
                    .font(.system(size: 18, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                    .frame(width: 100,height: 65, alignment: .leading)
                    .padding(.leading, 5)
                
                Text("-")
                    .padding(2)
                    .foregroundColor(.black)
                
                Text(destination.destination)
                    .font(.system(size: 18, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                    .frame(width: 100,height: 65, alignment: .leading)
                    .padding(.leading,5)
                
                VStack(content: {
                    Text(String(destination.point))
                        .font(.system(size: 30, weight: .heavy, design: .default))
                        .foregroundColor(.black)
                        .padding(.trailing,6)
                }).frame(width: 60, height: 65, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(.blue)
                    .offset(x:4)
                    .cornerRadius(8)
                                            
            }).frame(width:320,height: 65, alignment: .trailing)
                .cornerRadius(8)
                .background(isSelected ? .green : .white)
                .padding(.leading, 4)
                .cornerRadius(8)
        })
        .frame(width: 320, height: 65,alignment: .center)
        .cornerRadius(8)
        .shadow(radius: isSelected ? 8 : 0)
    }
}

//#Preview {
//    DestinationCard(destination: Destination(point: 10, origin: "New York", destination: "Miami"))
//}
