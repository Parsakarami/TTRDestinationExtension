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
        ZStack(content:{
//            NavigationSplitView {
//                LinearGradient(gradient: Gradient(colors:[.green, .blue]),
//                               startPoint: .topLeading, endPoint: .bottomTrailing)
//                .edgesIgnoringSafeArea(.all)
//                
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
//            } detail: {
//                Text("Select an item")
//            }
            
            GradientBackground(topColor: .blue, bottomColor: .black)
            
            HStack(alignment: .bottom, spacing: 10, content: {
                VStack(alignment: .trailing, content: {
                    CustomButton(text: "User 1", systemImage: "plus", function: addItem)
                    CustomButton(text: "User 2", systemImage: "plus", function: addItem)
                    CustomButton(text: "User 3", systemImage: "plus", function: addItem)
                    })
            }).frame(alignment: .trailing)
            
        })
    }

    private func addItem() {
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
            Label(text, systemImage: systemImage).foregroundColor(.blue)
        }
        .frame(width: 200,height: 30)
        .padding(10)
        .background(.white)
        .cornerRadius(4.5)
    }
}
