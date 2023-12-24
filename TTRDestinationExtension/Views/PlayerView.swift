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
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel : PlayerViewModel
    
    init(player: User) {
        _viewModel = StateObject(wrappedValue: PlayerViewModel(player: player))
    }
    
    var body: some View {
        ZStack{
            GradientBackground(topColor: .blue, bottomColor: .black)
            VStack(alignment: .center, spacing: 20, content: {
                PlayerInformationCard(player: $viewModel.player)
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
                    NavigationLink(destination: MainView(modelContext: self.modelContext))
                        { CustomButton(text: "Home Page", systemImage: "house", function: {}) }
                }
            })
        }.navigationBarHidden(true)
    }
}
