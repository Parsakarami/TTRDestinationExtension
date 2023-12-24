//
//  LoginView.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-18.
//

import SwiftUI

struct LoginView : View {
    @Environment(\.modelContext) private var dbContext
    @State var player : User
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
                ZStack(content: {
                    GradientBackground(topColor: .blue, bottomColor: .black)
                    VStack(alignment: .center, spacing: 20, content: {
                        Spacer()
                        VStack(spacing: 10, content: {
                            Text("Player name")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .frame(alignment: .trailing)
                                .aspectRatio(contentMode: .fit)
                            
                            Text(player.name)
                                .font(.system(size: 45, weight: .bold, design: .default))
                                .frame(alignment: .center)
                                .foregroundColor(.white)
                                .offset(x:0,y:-10)
                            
                            SecureField("Password", text: $viewModel.password,prompt: Text("Password").foregroundColor(.gray))
                                .frame(width: 200,height: 30)
                                .padding(10)
                                .foregroundColor(.black)
                                .background(.white)
                                .keyboardType(.numberPad)
                                .cornerRadius(6)
                                .onChange(of: viewModel.password) {
                                    viewModel.login(correctPassword: player.password)
                                }
                        }).frame(width: 400,height: 150,alignment: .center)
                            .padding(.bottom,20)
                        
                        VStack(spacing: 5, content: {
                            if (viewModel.isAuthorized) {
                                
                                NavigationLink(destination:
                                                DestinationView(modelContext: dbContext, player: player)) {
                                    CustomButton(text: "Choose New Tickets",
                                                 systemImage: "",
                                                 function: viewModel.doNothing,
                                                 backColor: .blue,
                                                 foreColor: .white
                                    )}
                                
                                NavigationLink(destination:
                                                PlayerView(player: player)) {
                                    CustomButton(text: "See Profile",
                                                 systemImage: "",
                                                 function: viewModel.doNothing,
                                                 backColor: .blue,
                                                 foreColor: .white
                                    )}
                                
                            } else {
                                CustomButton(text: "Not Authorized",
                                             systemImage: "lock.fill",
                                             function: viewModel.doNothing,
                                             backColor: .gray,
                                             foreColor: .white
                                ).disabled(false)
                            }
                        }).frame(width: 400,height: 77, alignment: .bottom)
                        
                        NavigationLink(destination: MainView(modelContext: self.dbContext)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true))
                            {
                                CustomButton(text: "Back", systemImage: "arrow.left", function: {})
                            }
                    })
                    .frame(width: 400, height: 400, alignment: .center)
                    .padding(50)
                }).navigationBarBackButtonHidden(true)
    }
}



#Preview {
    LoginView(player: User(name: "Parsa", password: nil, color: nil))
}
