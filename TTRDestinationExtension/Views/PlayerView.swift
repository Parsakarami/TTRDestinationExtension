//
//  PlayerView.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-22.
//

import Foundation
import SwiftUI
import SwiftData

struct PlayerView : View {
    @StateObject var viewModel : PlayerViewModel
    
    init(player: User) {
        player.destinationTickets.sorted(by: {$0.point < $1.point})
        _viewModel = StateObject(wrappedValue: PlayerViewModel(player: player))
    }
    
    var body: some View {
        ZStack{
            GradientBackground(topColor: .blue, bottomColor: .black)
            VStack(alignment: .center, spacing: 20, content: {
                HStack(content: {
                    Label(viewModel.player.name, systemImage: "")
                        .font(.system(size: 30, weight: .heavy, design: .default))
                        .frame(width: 100,height: 80, alignment: .leading)
                        .padding(.leading, 10)
                    Spacer()
                    VStack(content: {
                        Label("points", systemImage: "")
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .frame(width: 100,height: 25, alignment: .center)
                            .padding(.top,15)
                        Label(String(viewModel.player.totalPoints), systemImage: "profile")
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
                .background(Color(byName: viewModel.player.color))
                .cornerRadius(8)
                
                Spacer()
                
                ScrollView{
                    VStack(spacing: 8, content: {
                        ForEach(viewModel.player.destinationTickets) { ticket in
                            DestinationCard(destination: ticket, isSelected: .constant(false))
                        }
                    })
                }
                
                Spacer()
                    VStack{
                            NavigationLink(destination: MainView())
                            { CustomButton(text: "Home Page", systemImage: "house", function: {}) }
                    }
            })
        }.navigationBarHidden(true)
    }
}
