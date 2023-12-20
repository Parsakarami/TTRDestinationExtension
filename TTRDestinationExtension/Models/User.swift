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
    var color: String
    var password: String
    var totalPoints:Int = 0
    var destinationTickets: [Destination] = []
    
    init(name: String, password: String?, color: String?) {
        self.name = name
        self.password = password ?? "1234"
        self.color = color ?? "green"
    }
    
    func addDestination(destination: Destination){
        destinationTickets.append(destination)
        totalPoints = totalPoints + destination.point
    }
}
