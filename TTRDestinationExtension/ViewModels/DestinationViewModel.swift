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
    @Published var isAdded : Bool = false
    
    init(context: ModelContext, player: User) {
        self.dbContext = context
        self.player = player
        fetchData()
        seedDestination()
    }
    
    private func seedDestination(){
        self.threeDestinations.append(Destination(point: 21, origin: "New York", destination: "Los Angles",uuid: nil))
        self.threeDestinations.append(Destination(point: 17, origin: "San Fransisco", destination: "Atlanta",uuid: nil))
        self.threeDestinations.append(Destination(point: 12, origin: "Torotno", destination: "Miami",uuid: nil))
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
        }
        
        if(isSecondSelected){
            player.addDestination(destination: threeDestinations[1])
        }
        
        if(isThirdSelected){
            player.addDestination(destination: threeDestinations[2])
        }
        
//        do {
//            try dbContext.save()
//        } catch {
//            print("Error saving entity: \(error.localizedDescription)")
//        }
    }
    
    private func fetchData(){
        do {
            let descriptor = FetchDescriptor<Destination>(sortBy: [SortDescriptor(\.point)])
            destinations = try dbContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
}
