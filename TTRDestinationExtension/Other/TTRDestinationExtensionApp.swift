//
//  TTRDestinationExtensionApp.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-16.
//

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseFirestore

@main
struct TTRDestinationExtensionApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            User.self,
            Destination.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(sharedModelContainer)
    }
    
    init()
    {
        FirebaseApp.configure()
        seedDestination()
    }
    
    func seedDestination() {
        let db = Firestore.firestore()
            let ticketDocument = db.collection("tickets").document("1")
            ticketDocument.getDocument { (document, error) in
                        if let error = error {
                            print("Error getting document: \(error)")
                        } else if let document = document, document.exists {
                            do {
                                let ticket = try document.data(as: Ticket.self)
                                
                            } catch {
                                print("Error decoding document: \(error)")
                            }
                        } else {
                            print("Document does not exist")
                        }
        }
    }
}
