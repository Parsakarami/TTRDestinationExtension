//
//  MainViewModel.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-18.
//

import Foundation
import SwiftData
import FirebaseFirestore

class MainViewModel: ObservableObject{
    private var tickets: [Ticket] = []
    private var dbContext: ModelContext
    private var isInitilized : Bool = false
    @Published var destinationCounts : Int = 0
    @Published var isDestinationFetched : Bool = false
    
    init(context: ModelContext) {
        self.dbContext = context
        if !self.isInitilized {
            seedDestinationFromFirestore()
            self.isInitilized = true
        }
    }
    
    func fetchDestination(){
        do {
            tickets.forEach { ticket in
                dbContext.insert(Destination(ticket: ticket))
            }
            try dbContext.save()
            destinationCounts = tickets.count
            isDestinationFetched = destinationCounts > 0
        } catch {
            print("Cannot save in the local database. error details: \(error)")
        }
    }
    
    func resetPoints(){
        // Fetch users
        // Clear points and destination
        let userDescriptor = FetchDescriptor<User>(sortBy: [SortDescriptor(\.name)])
        let users = try? dbContext.fetch(userDescriptor)
        users?.forEach { user in
            user.totalPoints = 0
            user.destinationTickets.removeAll()
        }
        
        // Update selected destinations to notSelected
        let destinationDescriptor = FetchDescriptor<Destination>(sortBy: [SortDescriptor(\.point)])
        let destinations = try? dbContext.fetch(destinationDescriptor)
        let unSelectedDestinations = destinations?.filter{ return $0.isSelected == true }
            
        unSelectedDestinations?.forEach { item in
            item.isSelected = false
        }
        
        try? dbContext.save()
    }
    
    private func seedDestinationFromFirestore(){
        let db = Firestore.firestore()
            let ticketCollection = db.collection("tickets")
            ticketCollection.getDocuments {(querySnapshot, error) in
                        if let error = error {
                            print("Error getting document: \(error)")
                        } else {
                            do {
                                for document in querySnapshot!.documents {
                                    let ticket = try document.data(as: Ticket.self)
                                    self.tickets.append(ticket)
                                }
                            } catch {
                                print("Error decoding document: \(error)")
                            }
                        }
        }
    }
}
