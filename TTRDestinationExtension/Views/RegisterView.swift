//
//  RegisterView.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-19.
//

import SwiftUI
import SwiftData

struct RegisterView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel : RegisterViewModel
    @State var selectColor : String = "green"
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: RegisterViewModel(context: modelContext))
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
                        
                        VStack{
                            Label("Choose your color", systemImage: "")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .frame(alignment: .leading)
                            .foregroundColor(.white)
                            .padding(10)
                            
                            HStack{
                                Button(action: {
                                    selectColor = "green"
                                    viewModel.setColor(color: selectColor)
                                }, label: {
                                    PlayerColorButton(isMatch: selectColor == "green", bgColor: .green)
                                })
                                Button(action: {
                                    selectColor = "black"
                                    viewModel.setColor(color: selectColor)
                                }, label: {
                                    PlayerColorButton(isMatch: selectColor == "black", bgColor: .black)
                                })
                                Button(action: {
                                    selectColor = "yellow"
                                    viewModel.setColor(color: selectColor)
                                }, label: {
                                    PlayerColorButton(isMatch: selectColor == "yellow", bgColor: .yellow)
                                })
                                Button(action: {
                                    selectColor = "blue"
                                    viewModel.setColor(color: selectColor)
                                }, label: {
                                    PlayerColorButton(isMatch: selectColor == "blue", bgColor: .blue)
                                })
                                Button(action: {
                                    selectColor = "red"
                                    viewModel.setColor(color: selectColor)
                                }, label: {
                                    PlayerColorButton(isMatch: selectColor == "red", bgColor: .red)
                                })
                            }
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
                               label: { CustomButton(text: "Add Player",
                                         systemImage: "",
                                         function: viewModel.register,
                                         backColor: viewModel.isSuccessful ? .gray : .green,
                                         foreColor: .white) })
                        .disabled(viewModel.isSuccessful)
                        
                        NavigationLink(destination: MainView(modelContext: self.modelContext)
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
}

