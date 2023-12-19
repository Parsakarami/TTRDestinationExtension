//
//  LoginView.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-18.
//

import SwiftUI

struct LoginView : View {
    @State var user: String
    @State var password: String
    var body: some View {
                ZStack(content: {
                    GradientBackground(topColor: .blue, bottomColor: .black)
                    VStack(alignment: .center, spacing: 20, content: {
                        Spacer()
                        
                        Text(user)
                            .font(.system(size: 35, weight: .bold, design: .default))
                            .frame(alignment: .center)
                            .foregroundColor(.white)
                        
                        Text("Enter Password")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .frame(alignment: .trailing)
                            .aspectRatio(contentMode: .fit)
                        
                        SecureField("Password", text: $password)
                            .frame(width: 200,height: 30)
                            .padding(10)
                            .background(.white)
                            .cornerRadius(4.5)
                        
                        NavigationLink(destination: DestinationView()
                            .navigationBarTitle("", displayMode: .inline)
                            .navigationBarHidden(true))
                        { CustomButton(text: "Login", systemImage: "key", function: login) }
                        NavigationLink(destination: MainView()
                            .navigationBarTitle("", displayMode: .inline)
                            .navigationBarHidden(true))
                        { CustomButton(text: "Back", systemImage: "arrow.left", function: login) }
                        
                        Spacer()
                    })
                    .frame(width: 400, height: 400, alignment: .centerLastTextBaseline)
                    .padding(50)
                })
    }
    
    private func login()
    {
        
    }
}



#Preview {
    LoginView(user:"",password:"")
}
