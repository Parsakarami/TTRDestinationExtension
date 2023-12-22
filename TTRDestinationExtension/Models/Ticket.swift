//
//  Ticket.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-22.
//

import Foundation

struct Ticket : Codable {
    var id: String
    var point: Int
    var origin: String
    var destination: String
    init(id: String?, point: Int, origin: String, destination: String) {
        self.id = id ?? String(Date().timeIntervalSinceReferenceDate)
        self.point = point
        self.origin = origin
        self.destination = destination
    }
}
