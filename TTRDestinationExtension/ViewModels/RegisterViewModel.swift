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
    @Published var selectedColor : String = "green"
    @Published var colors : [String] = ["green", "black", "yellow", "blue", "red"]
    @Published var message : String = ""
    @Published var isAttempted : Bool = false
    @Published var isSuccessful : Bool = false
    @Published var isHitMaximumSize : Bool = false
    private let MAXIMUM_USER = 5
    private var dbContext: ModelContext
    private var users = [User]()
    
    init(context: ModelContext) {
        self.dbContext = context
        initialize()
    }
    
    func register() {
        isAttempted = true
        isSuccessful = validate()
        if isSuccessful {
            let newUser = User(name: username,password: password, color: selectedColor)
            dbContext.insert(newUser)
            message = "Added!"
            removeColor(color: self.selectedColor)
            
            let userCount = users.count + 1
            isHitMaximumSize = userCount == MAXIMUM_USER
        }
    }
    
    func reset() {
        initialize()
    }
    
    private func validate() -> Bool {
        
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty else{
            message = "Username is required."
            return false
        }
        
        guard !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            message = "Password is required."
            return false
        }
        
        return true
    }
    
    private func initialize(){
        fetchData()
        isHitMaximumSize = users.count == MAXIMUM_USER
        removeInUsedColors()
        message = ""
        username = ""
        password = ""
        selectedColor = colors.first ?? colors.last ?? "red"
        isAttempted = false
        isSuccessful = false
    }
    
    private func removeInUsedColors(){
        users.forEach { user in
            removeColor(color: user.color)
        }
    }
    
    private func removeColor(color: String){
        let colorIndex = colors.firstIndex(of: color) ?? -1
        if(colorIndex > -1) {
            self.colors.remove(at: colorIndex)
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
