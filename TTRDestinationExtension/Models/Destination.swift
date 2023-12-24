//
//  Destination.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-18.
//

import Foundation
import SwiftData

@Model
final class Destination {
    var id: String
    var point: Int
    var origin: String
    var destination: String
    var isSelected: Bool
    init(point: Int, origin: String, destination: String, uuid: String?, isSelected: Bool?) {
        self.id = uuid ?? UUID().uuidString
        self.point = point
        self.origin = origin
        self.destination = destination
        self.isSelected = isSelected ?? false
    }
    
    init(ticket: Ticket){
        self.id = ticket.id
        self.point = ticket.point
        self.origin = ticket.origin
        self.destination = ticket.destination
        self.isSelected = false
    }
}
