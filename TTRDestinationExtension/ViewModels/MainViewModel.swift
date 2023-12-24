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
        } catch {
            print("Cannot save in the local database. error details: \(error)")
        }
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
