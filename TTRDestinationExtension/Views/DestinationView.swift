//
//  DestinationView.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-18.
//

import SwiftUI

struct DestinationView : View {
    var body: some View {
        ZStack{
            GradientBackground(topColor: .green, bottomColor: .blue)
            VStack(alignment: .center, spacing: 20, content: {
                Spacer()
                Label("User 1", systemImage: "profile")
                    .font(.system(size: 35, weight: .bold, design: .default))
                    .frame(alignment: .center)
                    .foregroundColor(.white)
                
                NavigationLink(destination: MainView()
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(false))
                { CustomButton(text: "Home Page", systemImage: "house", function: addCard) }
                Spacer()
            })
        }
    }
    
    private func addCard()
    {
        
    }
}

#Preview {
    DestinationView()
}
