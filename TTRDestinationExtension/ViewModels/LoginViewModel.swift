//
//  LoginViewModel.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-18.
//

import Foundation
import Combine
class LoginViewModel : ObservableObject {
    @Published var user : String = ""
    @Published var password : String = ""
    @Published var isAuthorized : Bool = false
    
    func login(correctPassword: String){
        isAuthorized = correctPassword == password
    }
    
    func doNothing(){
        
    }
}
