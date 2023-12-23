//
//  PlayerViewModel.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-22.
//

import Foundation

class PlayerViewModel : ObservableObject{
    @Published var player : User
    
    init(player: User) {
        self.player = player
    }
}
