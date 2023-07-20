//
//  ContentView.swift
//  CoreCo
//
//  Created by roger deutsch on 7/18/23.
//

import SwiftUI
import CoreData

enum Group: String, CaseIterable, Identifiable {
    case empty, selfManagement, dealWithOthers, dealWithBusiness
    var id: Self { self }
}

struct ContentView: View {
    let coreCompetencies : [CoreCompetency] = Bundle.main.decode("coreCompetencies")
    
    @State private var displayedCompetencies = [CoreCompetency]()
    
    @State private var selectedGroup: Group = Group.empty
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        VStack{
            Picker("Group (select to start)", selection: $selectedGroup) {
                    Text("(Select A Group To Begin)")
                        .tag(Group.empty)
                    Text("Self Management").tag(Group.selfManagement)
                    Text("Dealing With Others").tag(Group.dealWithOthers)
                    Text("Dealing With Business").tag(Group.dealWithBusiness)
                }
                .onChange(of: selectedGroup, perform: { newValue in
                    print("PICKER CHANGED \(selectedGroup)")
                    var groupName = ""
                    switch (selectedGroup){
                    case .empty:
                        groupName = ""
                    case .selfManagement:
                        groupName = "Self Management"
                    case .dealWithOthers:
                        groupName = "Dealing With People"
                    case .dealWithBusiness:
                        groupName = "Dealing With Business"
                    }
                    displayedCompetencies = getCompetenciesByGroup(group: groupName)
                })
            
            NavigationView {
                List {
                    ForEach(displayedCompetencies) { item in
                        NavigationLink {
                            Text("Item at \(item.title) ")
                        } label: {
                            Text(item.title)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            
            }
            
            
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func getCompetenciesByGroup(group: String) -> ([CoreCompetency]){
        var allMatching = [CoreCompetency]()
        _ = coreCompetencies.map({
            if $0.group == group {
                allMatching.append($0)
            }
        })
        return allMatching
    }
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
