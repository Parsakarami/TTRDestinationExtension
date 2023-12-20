//
//  RegisterView.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-19.
//

import SwiftUI
import SwiftData

struct RegisterView: View {
    @State var viewModel : RegisterViewModel
    init(modelContext: ModelContext) {
        viewModel = RegisterViewModel(context: modelContext)
    }
    
    var body: some View {
        NavigationView {
            ZStack(content: {
                GradientBackground(topColor: .blue, bottomColor: .black)
                VStack(alignment: .center, spacing: 20, content: {
                    Header()
                        .padding()
                    Spacer()
                    
                    VStack{
                        
                        TextField("Player name", text: $viewModel.username)
                            .frame(width: 200,height: 20)
                            .padding(10)
                            .background(.white)
                            .cornerRadius(4.5)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .keyboardType(.namePhonePad)
                        
                        SecureField("Password", text: $viewModel.password)
                            .frame(width: 200,height: 20)
                            .padding(10)
                            .background(.white)
                            .cornerRadius(4.5)
                            .keyboardType(.numberPad)
                        
                        HStack{
                            Button(action: setGreenColor, label: {
                                PlayerColorButton(isMatch: viewModel.color == "green", bgColor: .green)
                            })
                            Button(action: setBlackColor, label: {
                                PlayerColorButton(isMatch: viewModel.color == "black", bgColor: .black)
                            })
                            Button(action: setYellowColor, label: {
                                PlayerColorButton(isMatch: viewModel.color == "yellow", bgColor: .yellow)
                            })
                            Button(action: setBlueColor, label: {
                                PlayerColorButton(isMatch: viewModel.color == "blue", bgColor: .blue)
                            })
                            Button(action: setRedColor, label: {
                                PlayerColorButton(isMatch: viewModel.color == "red", bgColor: .red)
                            })
                        }
                        
                        if viewModel.isAttempted {
                            Label(viewModel.message,
                            systemImage: viewModel.isSuccessful ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .frame(alignment: .center)
                            .foregroundColor(viewModel.isSuccessful ? .green : .yellow)
                            .padding()
                        }
                        
                        Spacer()
                        
                        Button(action: viewModel.register,
                               label: { CustomButton(text: "Register",
                                         systemImage: "",
                                         function: viewModel.register,
                                         backColor: viewModel.isSuccessful ? .gray : .green,
                                         foreColor: .white) })
                        .disabled(viewModel.isSuccessful)
                        
                        NavigationLink(destination: MainView()
                            .navigationBarTitle("", displayMode: .inline)
                            .navigationBarHidden(true))
                        { CustomButton(text: "Back", systemImage: "", function: {}) }
                    }
                    .frame(width: 400, height: 400, alignment: .centerLastTextBaseline)
                    .padding(50)
                })
            })
        }.navigationBarBackButtonHidden(true)
    }
    
    private func setGreenColor(){
        viewModel.setColor(color: "green")
    }
    private func setBlackColor(){
        viewModel.setColor(color: "black")
    }
    private func setYellowColor(){
        viewModel.setColor(color: "yellow")
    }
    private func setBlueColor(){
        viewModel.setColor(color: "blue")
    }
    private func setRedColor(){
        viewModel.setColor(color: "red")
    }
}
