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
                        VStack{
                            if !viewModel.isHitMaximumSize {
                                TextField("", text: $viewModel.username, prompt: Text("Player name").foregroundColor(.gray))
                                    .frame(width: 200,height: 20)
                                    .padding(10)
                                    .foregroundColor(.black)
                                    .background(.white)
                                    .autocorrectionDisabled()
                                    .autocapitalization(.none)
                                    .keyboardType(.namePhonePad)
                                    .cornerRadius(6)
                                
                                SecureField("", text: $viewModel.password, prompt: Text("Password").foregroundColor(.gray))
                                    .frame(width: 200,height: 20)
                                    .padding(10)
                                    .foregroundColor(.black)
                                    .background(.white)
                                    .keyboardType(.numberPad)
                                    .cornerRadius(6)
                                
                                VStack{
                                    Label("Choose your color", systemImage: "")
                                        .font(.system(size: 18, weight: .medium, design: .default))
                                        .frame(alignment: .leading)
                                        .foregroundColor(.white)
                                        .padding(10)
                                    
                                    HStack{
                                        ForEach(viewModel.colors, id: \.self) { color in
                                            Button(action: {
                                                viewModel.selectedColor = color
                                            }, label: {
                                                PlayerColorButton(isMatch: viewModel.selectedColor == color, bgColor: Color(byName: color) ?? .green )
                                            })
                                        }
                                    }
                                }
                            } else {
                                Label("All players are added!", systemImage: "")
                                    .font(.system(size: 20, weight: .medium, design: .default))
                                    .frame(alignment: .center)
                                    .foregroundColor(.white)
                                    .padding(10)
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
                        
                        VStack{
                            if !viewModel.isHitMaximumSize {
                                if !viewModel.isSuccessful {
                                    Button(action: viewModel.register,
                                           label: { CustomButton(text: "Add Player",
                                                                 systemImage: "",
                                                                 function: viewModel.register,
                                                                 backColor: .green,
                                                                 foreColor: .white) })
                                } else {
                                    Button(action: viewModel.reset,
                                           label: { CustomButton(text: "Reset From",
                                                                 systemImage: "",
                                                                 function: viewModel.reset,
                                                                 backColor: .blue,
                                                                 foreColor: .white) })
                                }
                            }
                        }.frame(width: UIScreen.main.bounds.width, height: 30, alignment: .center)
                            .padding()
                        
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

