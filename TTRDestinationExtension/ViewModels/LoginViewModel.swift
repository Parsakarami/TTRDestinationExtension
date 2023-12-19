//
//  LoginViewModel.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-18.
//

import Foundation

class LoginViewModel : ObservableObject {
    @Published var user : String = ""
    @Published var password : String = ""
    
    init() {}
    
    func setPassword(username: String, password: String)
    {
        self.user = username
        self.password = password
    }
    
    func login(){
        
    }
}


