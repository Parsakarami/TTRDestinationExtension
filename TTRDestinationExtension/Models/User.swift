//
//  User.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-18.
//

import Foundation
import SwiftData

@Model
final class User {
    var name: String
    var password: String
    var totalPoints:Int = 0
    var destinationTickets: [Destination] = []
    
    init(name: String, password: String?) {
        self.name = name
        self.password = password ?? "1234"
    }
    
    func addDestination(destination: Destination){
        destinationTickets.append(destination)
        totalPoints = totalPoints + destination.point
    }
}
