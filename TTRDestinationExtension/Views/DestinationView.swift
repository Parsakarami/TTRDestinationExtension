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
            GradientBackground(topColor: .blue, bottomColor: .blue)
            VStack(alignment: .center, spacing: 20, content: {
                
                Label("User 1", systemImage: "profile")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .frame(alignment: .center)
                    .foregroundColor(.white)
                    .padding(50)
                Spacer()
                
                VStack(spacing: 5, content: {
                    HStack(content: {
                        
                    })
                    .padding(2)
                    .frame(width: 320, height: 80)
                    .background(.gray)
                    .cornerRadius(8)
                    
                    HStack(content: {
                        
                    })
                    .padding(2)
                    .frame(width: 320, height: 80)
                    .background(.gray)
                    .cornerRadius(8)
                    
                    HStack(content: {
                        
                    })
                    .padding(2)
                    .frame(width: 320, height: 80)
                    .background(.gray)
                    .cornerRadius(8)
                })
                Spacer()
                NavigationLink(destination: MainView()
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(false))
                { CustomButton(text: "Home Page", systemImage: "house", function: addCard) }
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
