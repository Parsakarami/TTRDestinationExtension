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
    init(point: Int, origin: String, destination: String, uuid: String?) {
        self.id = uuid ?? UUID().uuidString
        self.point = point
        self.origin = origin
        self.destination = destination
    }
}
