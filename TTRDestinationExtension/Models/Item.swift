//
//  Item.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-16.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
