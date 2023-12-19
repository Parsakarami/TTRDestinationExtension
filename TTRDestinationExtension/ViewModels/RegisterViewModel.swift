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
    @Published var message : String = ""
    @Published var isAttempted : Bool = false
    @Published var isSuccessful : Bool = false
    
    private var dbContext: ModelContext
    private var users = [User]()
    init(context: ModelContext) {
        self.dbContext = context
        fetchData()
    }
    
    func register() {
        isAttempted = true
        
        //Validation
        if(users.count <= 4)
        {
            let newUser = User(name: username,password: password)
            dbContext.insert(newUser)
            isSuccessful = true
            message = "Added!"
        }
        else
        {
            message = "Hit the maximum player!"
        }
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
