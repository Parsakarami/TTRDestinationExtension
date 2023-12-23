//
//  PlayerInformationCard.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-23.
//

import SwiftUI

struct PlayerInformationCard: View {
    @Binding var player : User
    var body: some View {
        HStack(content: {
            Label(player.name, systemImage: "")
                .font(.system(size: 30, weight: .heavy, design: .default))
                .frame(width: 200,height: 80, alignment: .leading)
                .padding(.leading, 10)
            Spacer()
            VStack(content: {
                Label("points", systemImage: "")
                    .font(.system(size: 15, weight: .regular, design: .default))
                    .frame(width: 100,height: 25, alignment: .center)
                    .padding(.top,15)
                Label(String(player.totalPoints), systemImage: "profile")
                    .font(.system(size: 34, weight: .bold, design: .default))
                    .frame(width: 100,height: 55, alignment: .center)
                    .offset(x:0,y: -15)
            })
            .frame(width: 100,height: 80, alignment: .center)
        })
        .foregroundColor(.white)
        .frame(width: 320, height: 50, alignment: .leading)
        .padding(.top,15)
        .padding(.bottom,15)
        .background(Color(byName: player.color))
        .cornerRadius(8)
    }
}

#Preview {
    PlayerInformationCard(player: .constant(User(name: "Parsa", password: "", color: "green")))
}
