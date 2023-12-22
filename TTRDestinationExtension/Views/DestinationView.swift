//
//  DestinationView.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-18.
//

import SwiftUI

struct DestinationView : View {
    @State var player : User
    @State private var isFirstSelected : Bool = false
    @State private var isSecondSelected : Bool = false
    @State var isThirdSelected : Bool = false
    @State var isAdded : Bool = false
    var body: some View {
        ZStack{
            GradientBackground(topColor: .white, bottomColor: .blue)
            VStack(alignment: .center, spacing: 20, content: {
                
                Label(player.name, systemImage: "profile")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .frame(alignment: .center)
                    .foregroundColor(.white)
                    .frame(width: 300)
                    .padding(.top,20)
                    .padding(.bottom,20)
                    .background(Color(byName: player.color))
                    .cornerRadius(8)
                Spacer()
                
                VStack(spacing: 8, content: {
                    Button(action: {
                            isFirstSelected = !isFirstSelected
                    }, label: {
                            DestinationCard(destination: Destination(point: 21, origin: "New York", destination: "Los Angles"), isSelected: $isFirstSelected)
                    })
                    
                    Button(action: {
                        isSecondSelected = !isSecondSelected
                    }, label: {
                        DestinationCard(destination: Destination(point: 17, origin: "San Fransisco", destination: "Atlanta"),isSelected: $isSecondSelected)
                    })
                    
                    Button(action: {
                        isThirdSelected = !isThirdSelected
                    }, label: {
                        DestinationCard(destination: Destination(point: 12, origin: "Toronto", destination: "Miami"), isSelected: $isThirdSelected)
                    })
                })
                
                Spacer()
                VStack{
                    if isAdded {
                        NavigationLink(destination: MainView()
                            .navigationBarTitle("", displayMode: .inline)
                            .navigationBarHidden(false))
                        { CustomButton(text: "Home Page", systemImage: "house", function: doNothing) }
                    } else{
                        if isFirstSelected || isSecondSelected || isThirdSelected {
                            Button(action: {addDestination()}, label: {
                                CustomButton(text: "Add", systemImage: "plus", function: doNothing,backColor: .green, foreColor: .white)
                            })
                        } else{
                            CustomButton(text: "Not Selected", systemImage: "", function: doNothing, backColor: .red, foreColor: .white)
                        }
                    }}
            })
        }
    }
    
    private func addDestination(){
        
        //Add destination to the user
        
        //Save
        
        isAdded = true
    }
    
    private func doNothing(){
        
    }
}

#Preview {
    DestinationView(player: User(name: "Parsa", password: "1234", color: "green"))
}
