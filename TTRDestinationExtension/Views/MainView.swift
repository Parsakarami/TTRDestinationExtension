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
                    VStack(content: {
                        Label("Ticket to Ride", systemImage: "")
                            .font(.system(size: 35, weight: .bold, design: .default))
                            .frame(alignment: .center)
                            .foregroundColor(.white)
                        Label("Destination extension", systemImage: "train.side.front.car")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .frame(alignment: .center)
                            .foregroundColor(.white)
                    }).frame(width: UIScreen.main.bounds.width)
                    Spacer()
                    VStack{
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            CustomButton(text: "Add User", systemImage: "plus", function: addUser,backColor: .green, foreColor: .white)
                                .aspectRatio(contentMode: .fill)
                        })
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            CustomButton(text: "Clear", systemImage: "trash", function: resetForm, backColor: .red, foreColor: .white)
                        })
                    }
                    Spacer()
                    VStack{
                        ForEach(users) { user in
                            NavigationLink(destination: LoginView(user: "\(user.name)", password: "")
                                .navigationBarTitle("", displayMode: .inline)
                                .navigationBarHidden(true))
                            { CustomButton(text: "\(user.name)", systemImage: "", function: addItem) }
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
                let newUser = User(name: "User\(users.count + 1)")
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

#Preview {
    MainView()
        .modelContainer(for: Item.self, inMemory: true)
}
