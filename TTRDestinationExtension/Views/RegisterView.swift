//
//  RegisterView.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-19.
//

import SwiftUI
import SwiftData

struct RegisterView: View {
    @State private var viewModel : RegisterViewModel
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
                        
                        if(viewModel.isAttempted)
                        {
                            Label(viewModel.message, systemImage: viewModel.isSuccessful ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                                .flipsForRightToLeftLayoutDirection(true)
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .frame(alignment: .center)
                                .foregroundColor(viewModel.isSuccessful ? .green : .red)
                                .padding()
                        }
                        
                        Spacer()
                        
                        Button(action: viewModel.register,
                               label: { CustomButton(text: "Register",
                                         systemImage: "plus",
                                         function: viewModel.register,
                                         backColor: viewModel.isSuccessful ? .gray : .green,
                                         foreColor: .white) })
                        .disabled(viewModel.isSuccessful)
                        
                        NavigationLink(destination: MainView()
                            .navigationBarTitle("", displayMode: .inline)
                            .navigationBarHidden(true))
                        { CustomButton(text: "Back", systemImage: "arrow.left", function: {}) }
                    }
                    .frame(width: 400, height: 400, alignment: .centerLastTextBaseline)
                    .padding(50)
                })
            })
        }.navigationBarBackButtonHidden(true)
    }
    
}
