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
    @Query private var items: [Item] = []
    @Query private var users: [User] = []
    @StateObject var viewModel : MainViewModel
    @State private var isShowingConfirmation: Bool = false
    
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: MainViewModel(context: modelContext))
    }
    
    var body: some View {
        
        NavigationView {
            
                
            TabView {
                GradientStack{
                    VStack(alignment: .center, content: {
                        Header()
                        Spacer()
                        VStack{
                            ForEach(users) { user in
                                NavigationLink(destination: LoginView(player: user)
                                    .navigationBarTitle("", displayMode: .inline)
                                    .navigationBarHidden(true)) {
                                        CustomButton(text: "\(user.name)",
                                                     systemImage: "",
                                                     function: addItem,
                                                     backColor: Color(byName: user.color) ?? .white,
                                                     foreColor: .white)
                                    }
                            }   
                        }.frame(width: UIScreen.main.bounds.width)
                        Spacer()
                    }).padding(25)
                }
                .tabItem {
                    Label("Play",systemImage: "gamecontroller.fill")
                }
                        
                GradientStack{
                    VStack{
                        Header()
                        Spacer()
                        VStack{
                            NavigationLink(destination: RegisterView(modelContext: modelContext)
                                .navigationBarTitle("", displayMode: .inline)
                                .navigationBarHidden(true))
                            { CustomButton(text: "Add Player", systemImage: "plus", function: {}, backColor: .white, foreColor: .blue) }
                            
                            Button(action: { viewModel.fetchDestination()}
                                   , label: {
                                CustomButton(text: "Fetch Destination", systemImage: "wand.and.stars", function: resetForm, backColor: .blue, foreColor: .white)
                            })
                            
                            Button(action: {isShowingConfirmation = true}
                                   , label: {
                                CustomButton(text: "Clear", systemImage: "trash", function: resetForm, backColor: .red, foreColor: .white)
                            }).alert("Are you sure?", isPresented: $isShowingConfirmation) {
                                Button("Delete",role:.destructive) {resetForm()}
                            }
                        }
                        Spacer()
                    }.padding(25)
                }.tabItem {
                        Label("Settings",systemImage: "gearshape.fill")
                }.foregroundStyle(.white)
                    
            }.foregroundColor(.white)
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
                try modelContext.delete(model: Destination.self)
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



//#Preview {
//    MainView()
//        .modelContainer(for: [Item.self, User.self], inMemory: true)
//}
