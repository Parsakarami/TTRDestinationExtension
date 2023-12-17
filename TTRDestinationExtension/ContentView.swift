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
        ZStack {
            GradientBackground(topColor: .blue, bottomColor: .black)
            VStack(alignment: .center, content: {
                Label("Ticket to Ride", systemImage: "")
                    .font(.system(size: 35, weight: .bold, design: .default))
                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                Label("Destination extension", systemImage: "train.side.front.car")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    Spacer()
                    CustomButton(text: "User 1", systemImage: "", function: addItem)
                    CustomButton(text: "User 2", systemImage: "", function: addItem)
                    CustomButton(text: "User 3", systemImage: "", function: addItem)
            }).padding(25)
            
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
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

struct GradientBackground: View {
    var topColor: Color
    var bottomColor: Color
    var body: some View {
        LinearGradient(gradient: Gradient(colors:[topColor,bottomColor]),
                       startPoint: .topLeading, endPoint: .bottomTrailing)
                       .edgesIgnoringSafeArea(.all)
    }
}

struct CustomButton : View {
    var text: String
    var systemImage: String
    var function : () -> Void
    var body: some View {
        Button(action: function) {
            Image(systemName: "person.fill").padding(2)
            Label(text, systemImage: systemImage).foregroundColor(.blue)
        }
        .frame(width: 200,height: 30)
        .padding(10)
        .background(.white)
        .cornerRadius(4.5)
    }
}
