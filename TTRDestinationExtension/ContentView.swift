//
//  ContentView.swift
//  TTRDestinationExtension
//
//  Created by Parsa Karami on 2023-12-16.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground(topColor: .blue, bottomColor: .black)
                VStack(alignment: .center, content: {
                    Label("Ticket to Ride", systemImage: "")
                        .font(.system(size: 35, weight: .bold, design: .default))
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                    Label("Destination extension", systemImage: "train.side.front.car")
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                    Spacer()
                    
                    NavigationLink(destination: PasswordView(user: "User1", password: "1234")
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true))
                    { CustomButton(text: "User 1", systemImage: "", function: addItem) }
                    NavigationLink(destination: PasswordView(user: "User2", password: "1234")
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true))
                    { CustomButton(text: "User 2", systemImage: "", function: addItem) }
                    NavigationLink(destination: PasswordView(user: "User3", password: "1234")
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true))
                    { CustomButton(text: "User 3", systemImage: "", function: addItem) }
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
    
    struct PasswordView : View {
        var user: String
        var password: String
        var body: some View {
                    ZStack(content: {
                        GradientBackground(topColor: .blue, bottomColor: .black)
                        VStack(alignment: .center, spacing: 20, content: {
                            Spacer()
                            Text("Enter Password:")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .frame(alignment: .trailing)
                                .aspectRatio(contentMode: .fit)
                            
                            SecureField("Password", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("Apple")/*@END_MENU_TOKEN@*/)
                                .frame(width: 200,height: 30)
                                .padding(10)
                                .background(.white)
                                .cornerRadius(4.5)
                            
                            NavigationLink(destination: DestinationView()
                                .navigationBarTitle("", displayMode: .inline)
                                .navigationBarHidden(true))
                            { CustomButton(text: "Login", systemImage: "key", function: login) }
                            
                            Spacer()
                        })
                        .frame(width: 400, height: 400, alignment: .centerLastTextBaseline)
                        .padding(50)
                    })
        }
        
        private func login()
        {
            
        }
    }
    
    struct DestinationView : View {
        var body: some View {
            ZStack{
                GradientBackground(topColor: .green, bottomColor: .blue)
                VStack(alignment: .center, spacing: 20, content: {
                    Spacer()
                    Label("User 1", systemImage: "profile")
                        .font(.system(size: 35, weight: .bold, design: .default))
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                    
                    NavigationLink(destination: ContentView()
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(false))
                    { CustomButton(text: "Go Back", systemImage: "home", function: addCard) }
                    Spacer()
                })
            }
        }
        
        private func addCard()
        {
            
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
