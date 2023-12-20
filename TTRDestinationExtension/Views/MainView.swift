//
//  ContentView.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-16.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @Query private var users: [User]

    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground(topColor: .blue, bottomColor: .black)
                VStack(alignment: .center, content: {
                    Header()
                    Spacer()
                    VStack{
                        NavigationLink(destination: RegisterView(modelContext: modelContext)
                            .navigationBarTitle("", displayMode: .inline)
                            .navigationBarHidden(true))
                        { CustomButton(text: "Add Player", systemImage: "plus", function: {}, backColor: .white, foreColor: .blue) }

                        Button(action: resetForm, label: {
                            CustomButton(text: "Clear", systemImage: "trash", function: resetForm, backColor: .red, foreColor: .white)
                        })
                    }
                    Spacer()
                    
                    VStack{
                        ForEach(users) { user in
                            NavigationLink(destination: LoginView()
                                .navigationBarTitle("", displayMode: .inline)
                                .navigationBarHidden(true)) {
                                    CustomButton(text: "\(user.name)",
                                                 systemImage: "",
                                                 function: addItem,
                                                 backColor: Color(byName: user.color) ?? .white,
                                                 foreColor: .white)
                                }
                        }
                    }.frame(width: UIScreen.main.bounds.width,height: 400)
                }).padding(25)
            }
        }.navigationBarBackButtonHidden(true)
        
        
        //            NavigationSplitView {
        
        //                List {
        //                    ForEach(items) { item in
        //                        NavigationLink {
        //                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
        //                        } label: {
        //                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
        //                        }
        //                    }
        //                    .onDelete(perform: deleteItems)
        //                }
        //                .toolbar {
        //                    ToolbarItem(placement: .navigationBarTrailing) {
        //                        EditButton()
        //                    }
        //                    ToolbarItem {
        //                        Button(action: addItem) {
        //                            Label("Add Item", systemImage: "plus")
        //                        }
        //                    }
        //                }
        //
        //            } detail: {
        //                Text("Select an item")
        //            }.foregroundColor(.blue)
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func addUser() {
        if(users.count <= 4)
        {
            withAnimation {
                let newUser = User(name: "User\(users.count + 1)",password: nil, color: nil)
                modelContext.insert(newUser)
            }
        }
    }
    
    private func resetForm()
    {
        withAnimation {
            do {
                try modelContext.delete(model: User.self)
            }
            catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    private func goToUserPage(id: Int) {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

extension Color {
    
    init?(byName: String) {
        switch byName {
        case "clear":       self = .clear
        case "black":       self = .black
        case "white":       self = .white
        case "gray":        self = .gray
        case "red":         self = .red
        case "green":       self = .green
        case "blue":        self = .blue
        case "orange":      self = .orange
        case "yellow":      self = .yellow
        case "pink":        self = .pink
        case "purple":      self = .purple
        case "primary":     self = .primary
        case "secondary":   self = .secondary
        default:            return nil
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: [Item.self, User.self], inMemory: true)
}