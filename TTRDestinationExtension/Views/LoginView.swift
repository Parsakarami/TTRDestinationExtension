//
//  LoginView.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-18.
//

import SwiftUI

struct LoginView : View {
    @State var player : User
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
                ZStack(content: {
                    GradientBackground(topColor: .blue, bottomColor: .black)
                    VStack(alignment: .center, spacing: 20, content: {
                        Spacer()
                        
                        Text("Player name")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .frame(alignment: .trailing)
                            .aspectRatio(contentMode: .fit)
                        
                        Text(player.name)
                            .font(.system(size: 45, weight: .bold, design: .default))
                            .frame(alignment: .center)
                            .foregroundColor(.white)
                            .offset(x:0,y:-15)
                        
                        SecureField("Password", text: $viewModel.password)
                            .frame(width: 200,height: 30)
                            .padding(10)
                            .background(.white)
                            .cornerRadius(4.5)
                            .onChange(of: viewModel.password){ pass in
                                viewModel.login(correctPassword: player.password)
                            }
                        
                        if (viewModel.isAuthorized) {
                            NavigationLink(destination: DestinationView(player: player)){
                                    CustomButton(text: "Login",
                                           systemImage: "",
                                           function: viewModel.doNothing,
                                           backColor: .green,
                                           foreColor: .white
                                    )}
                            .navigationBarTitle("", displayMode: .inline)
                            .navigationBarHidden(true)
                        } else {
                            CustomButton(text: "Not Authorized",
                                   systemImage: "lock.fill",
                                   function: viewModel.doNothing,
                                   backColor: .gray,
                                   foreColor: .white
                            ).disabled(false)
                        }
                        
                        
                        NavigationLink(destination: MainView()
                            .navigationBarTitle("", displayMode: .inline)
                            .navigationBarHidden(true)){
                                CustomButton(text: "Back", systemImage: "arrow.left", function: viewModel.doNothing)
                            }
                        
                        Spacer()
                    })
                    .frame(width: 400, height: 400, alignment: .centerLastTextBaseline)
                    .padding(50)
                })
    }
}



#Preview {
    LoginView(player: User(name: "Parsa", password: nil, color: nil))
}
