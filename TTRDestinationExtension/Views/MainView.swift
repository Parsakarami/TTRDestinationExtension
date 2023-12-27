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
    @Query private var destinations: [Destination] = []
    @StateObject var viewModel : MainViewModel
    @State private var isShowingResetAllDataDialog: Bool = false
    @State private var isShowingResetAppPointsDialog: Bool = false
    @State private var isShowingEndGameDialog: Bool = false
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
                            if users.count > 0 {
                                Label("Choose your player", systemImage: "")
                                    .font(.system(size: 15, weight: .light, design: .default))
                                    .frame(alignment: .top)
                                    .foregroundColor(.white)
                                    .offset(x:0, y:-5)
                                
                                ForEach(users) { user in
                                    NavigationLink(destination: LoginView(player: user)
                                        .navigationBarTitle("", displayMode: .inline)
                                        .navigationBarHidden(true)) {
                                            CustomButton(text: "\(user.name) - \(user.destinationTickets.count)",
                                                         systemImage: "",
                                                         function: addItem,
                                                         backColor: Color(byName: user.color) ?? .white,
                                                         foreColor: .white)
                                        }
                                }
                            } else {
                                Label("No player has been added!", systemImage: "")
                                    .font(.system(size: 22, weight: .bold, design: .default))
                                    .frame(alignment: .center)
                                    .foregroundColor(.white)
                                    .padding(10)
                                Label("To add players, go to the settings", systemImage: "")
                                    .font(.system(size: 15, weight: .light, design: .default))
                                    .frame(alignment: .top)
                                    .foregroundColor(.white)
                                    .offset(x:0, y:-5)
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
                            HStack{
                                if users.count != 0{
                                    Label("^[\(users.count) player](inflect: true)", systemImage: "person.fill")
                                        .font(.system(size: 16, weight: .light, design: .default))
                                        .frame(alignment: .center)
                                        .foregroundColor(.white)
                                        .padding(.trailing,2)
                                }
                                
                                if destinations.count != 0 {
                                    Label("^[\(destinations.count) destination](inflect: true)", systemImage: "menucard.fill")
                                        .font(.system(size: 16, weight: .light, design: .default))
                                        .frame(alignment: .center)
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
                            .padding(.top,40)
                            Spacer()
                            Spacer()
                            NavigationLink(destination: RegisterView(modelContext: modelContext)
                                .navigationBarTitle("", displayMode: .inline)
                                .navigationBarHidden(true))
                            { CustomButton(text: "Add Player",
                                           systemImage: "plus",
                                           function: {},
                                           backColor: .white,
                                           foreColor: .blue) }
                            
                            Button(action: {
                                if destinations.count == 0 {
                                    viewModel.fetchDestination()
                                }
                            }, label: {
                                CustomButton(text: destinations.count == 0 ? "Fetch Destinations" : "Fetched",
                                             systemImage: "wand.and.stars",
                                             function: {},
                                             backColor: destinations.count == 0 ? .blue : .gray,
                                             foreColor: .white)
                            }).alert("\(viewModel.destinationCounts) destinations are added.", isPresented: $viewModel.isDestinationFetched) {}
                            
                            Spacer()
                            
                            Button(action: {isShowingResetAllDataDialog = true}
                                   , label: {
                                CustomButton(text: "Clear all data",
                                             systemImage: "trash",
                                             function: resetForm,
                                             backColor: .red,
                                             foreColor: .white)
                            }).alert("Are you sure?", isPresented: $isShowingResetAllDataDialog) {
                                Button("Delete", role:.destructive) {
                                    resetForm()
                                    isShowingResetAllDataDialog = false
                                }
                            }
                        }
                    }.padding(25)
                }.tabItem {
                        Label("Settings",systemImage: "gearshape.fill")
                }.foregroundStyle(.white)
                
                
                GradientStack{
                    VStack{
                        Spacer()
                        VStack {
                            
                            if viewModel.isGameEnded {
                                Button(action: {
                                    isShowingResetAppPointsDialog = true
                                }, label: {
                                    CustomButton(text: "Reset points",
                                                 systemImage: "arrow.clockwise",
                                                 function: {},
                                                 backColor: .white,
                                                 foreColor: .red)
                                }).alert("Are you sure?", isPresented: $isShowingResetAppPointsDialog) {
                                    Button("Delete", role:.destructive) {
                                        viewModel.resetPoints()
                                        isShowingResetAppPointsDialog = false
                                    }
                                }
                            } else {
                                Button(action: {
                                    isShowingEndGameDialog = true
                                }, label: {
                                    CustomButton(text: "End Game",
                                                 systemImage: "flag.checkered.2.crossed",
                                                 function: {},
                                                 backColor: .white,
                                                 foreColor: .red)
                                }).alert("Are you sure?", isPresented: $isShowingEndGameDialog) {
                                    Button("Yes", role:.destructive) {
                                        viewModel.endGame()
                                        isShowingEndGameDialog = false
                                    }
                                }
                            }
                            
                        }
                        Spacer()
                        
                        VStack{
                            if viewModel.isGameEnded {
                                let usersByPoints = users.sorted(by: { u1,u2 in return u1.totalPoints > u2.totalPoints})
                                ForEach (usersByPoints) { userItem in
                                    PlayerInformationCard(player: .constant(userItem))
                                }
                            }
                        }.frame(width: UIScreen.main.bounds.width, height: 500, alignment: .center)
                        Spacer()
                    }
                }.tabItem {
                    Label("End game",systemImage: "flag.checkered")
                }
                    
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
