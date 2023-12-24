//
//  DestinationViewModel.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-22.
//

import Foundation
import SwiftData

class DestinationViewModel : ObservableObject{
    private var dbContext: ModelContext	
    private var destinations = [Destination]()
    @Published var threeDestinations : [Destination] = []
    @Published var player : User
    @Published var isFirstSelected : Bool = false
    @Published var isSecondSelected : Bool = false
    @Published var isThirdSelected : Bool = false
    @Published var isEmpty : Bool = false
    @Published var isAdded : Bool = false
    
    init(context: ModelContext, player: User) {
        self.dbContext = context
        self.player = player
        fetchData()
        setThreeRandomDestinations()
    }
    
    private func setThreeRandomDestinations(){
        
        if(destinations.count >= 3) {
            threeDestinations = Array(destinations.prefix(3))
        } else {
            isEmpty = true
        }
        
    }
    
    func selectDestination(index: Int)
    {
        switch index{
        case 0:
            isFirstSelected = !isFirstSelected
            break
        case 1:
            isSecondSelected = !isSecondSelected
            break
        case 2:
            isThirdSelected = !isThirdSelected
            break
        default:
            break
        }
    }
    
    func addSelectedDestination() {
        if(isFirstSelected){
            player.addDestination(destination: threeDestinations[0])
            threeDestinations[0].isSelected = true
        }
        
        if(isSecondSelected){
            player.addDestination(destination: threeDestinations[1])
            threeDestinations[1].isSelected = true
        }
        
        if(isThirdSelected){
            player.addDestination(destination: threeDestinations[2])
            threeDestinations[2].isSelected = true
        }
        
        try? dbContext.save()
    }
    
    private func fetchData(){
        do {
            let descriptor = FetchDescriptor<Destination>(sortBy: [SortDescriptor(\.point)])
            destinations = try dbContext.fetch(descriptor).filter {ticket in
                return !ticket.isSelected
            }.shuffled()
        } catch {
            print("Fetch failed")
        }
    }
}
