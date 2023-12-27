//
//  DestinationView.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-18.
//

import SwiftUI
import SwiftData

struct DestinationView : View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel : DestinationViewModel
    
    init(modelContext: ModelContext, player: User) {
        _viewModel = StateObject(wrappedValue: DestinationViewModel(context: modelContext, player: player))
    }
    
    var body: some View {
        ZStack{
            GradientBackground(topColor: .blue, bottomColor: .black)
            VStack(alignment: .center, spacing: 20, content: {
                PlayerInformationCard(player: $viewModel.player)
                Spacer()
                VStack(spacing: 8, content: {
                    if viewModel.isEmpty {
                        Label("No more destinations are available.",
                        systemImage: "")
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .padding()
                    } else {
                        Button(action: { viewModel.selectDestination(index: 0) }, label: {
                            DestinationCard(destination: viewModel.threeDestinations[0],isSelected: $viewModel.isFirstSelected) })
                        
                        Button(action: { viewModel.selectDestination(index: 1) }, label: {
                            DestinationCard(destination: viewModel.threeDestinations[1],isSelected: $viewModel.isSecondSelected) })
                        
                        Button(action: { viewModel.selectDestination(index: 2) }, label: {
                            DestinationCard(destination: viewModel.threeDestinations[2],isSelected: $viewModel.isThirdSelected) })
                    }
                }).frame(alignment: .center)
                Spacer()
                VStack {
                    ForEach (viewModel.player.destinationTickets) { dest in
                        DestinationCompactView(destinations: dest)
                    }
                }
                Spacer()
                VStack{
                    Spacer()
                    VStack{
                        if !viewModel.isEmpty {
                            if viewModel.isFirstSelected || viewModel.isSecondSelected || viewModel.isThirdSelected {
                                if viewModel.isAdded {
                                    CustomButton(text: "Added", systemImage: "chechmark", function: {},backColor: .green, foreColor: .white)
                                } else {
                                    Button(action: { viewModel.addSelectedDestination()}, label: {
                                        CustomButton(text: "Add", systemImage: "plus", function: {},backColor: .white, foreColor: .blue) })
                                }
                            } else {
                                CustomButton(text: "Not Selected", systemImage: "", function: {}, backColor: .red, foreColor: .white)
                            }
                        }
                    }
                    VStack{
                        if viewModel.isAdded || viewModel.isEmpty {
                            NavigationLink(destination: MainView(modelContext: self.modelContext)
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true))
                            { CustomButton(text: "Home Page", systemImage: "house", function: {}) }
                        }
                    }
                }
            })
        }.navigationBarHidden(true)
    }
}

//#Preview {
//    DestinationView( ,player: nil)
//}
