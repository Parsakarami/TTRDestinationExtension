//
//  RegisterViewModel.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-19.
//

import Foundation
import SwiftData

class RegisterViewModel : ObservableObject{
    @Published var username : String = ""
    @Published var password : String = ""
    @Published var color : String = "green"
    
    @Published var message : String = ""
    @Published var isAttempted : Bool = false
    @Published var isSuccessful : Bool = false
    
    private var dbContext: ModelContext
    private var users = [User]()
    
    init(context: ModelContext) {
        self.dbContext = context
        fetchData()
    }
    
    func setColor(color: String){
        self.color = color
    }
    
    func register() {
        isAttempted = true
        isSuccessful = validate()
        if isSuccessful {
            let newUser = User(name: username,password: password, color: color)
            dbContext.insert(newUser)
            message = "Added!"
        }
    }
    
    func validate() -> Bool {
        
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty else{
            message = "Username is required."
            return false
        }
        
        guard !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            message = "Password is required."
            return false
        }
        
        guard users.count <= 4 else {
            message = "You hit the maximum player!"
            return false
        }
        
        return true
    }
    
    private func fetchData(){
        do {
            let descriptor = FetchDescriptor<User>(sortBy: [SortDescriptor(\.name)])
            users = try dbContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
}
