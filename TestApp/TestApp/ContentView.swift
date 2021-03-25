//
//  ContentView.swift
//  TestApp
//
//  Created by Luis Alessandro Vitte Soto on 20/02/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Item.entity(), sortDescriptors: []) var items: FetchedResults<Item>
    
    func deleteItem (ItemIndex: Int){
            let deletedItem = self.items[ItemIndex]
            moc.delete(deletedItem)
        }
    
    @State var isPresentedAddItem = false
    
    var body: some View {
        NavigationView {
            List {
                
                ForEach(items, id: \.self) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        Text(item.wrappedName)
                    }
                }.onDelete { indexSet in
                    self.deleteItem(ItemIndex: indexSet.first!)
                }
                
            }.listStyle(InsetListStyle())
            .navigationTitle("Todo list")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.isPresentedAddItem.toggle()
                                    }) {
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .frame(width: 25, height: 25, alignment: .center)
                                            .foregroundColor(.blue)
                                    }.sheet(isPresented: $isPresentedAddItem) {
                                        AddItemView()
                                    }
            )
        }
    }
}

struct AddItemView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State var todotext: String = ""
    @State var todocomment: String = ""
    @State var tododate = Date()
    
    func saveItem() {
        
        let item = Item(context: self.moc)
        item.name = self.todotext
        item.comment = self.todocomment
        item.date = self.tododate
        
        try? self.moc.save()
        self.presentationMode.wrappedValue.dismiss()
        
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Reminde me...", text: $todotext)
                    
                    TextField("Comment here!", text: $todocomment)
                    
                    DatePicker(selection: $tododate, displayedComponents: .date) {
                        Text("Select a date")
                    }.datePickerStyle(DefaultDatePickerStyle())
                }
                
                Section {
                    Button(action: {
                        saveItem()
                    }) {
                        HStack {
                            Spacer()
                            Text("Add new")
                            Spacer()
                        }
                    }
                }
                .navigationTitle("Add new")
                .navigationBarItems(trailing:
                                        Button(action: {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }) {
                                            Text("Cancel")
                                                .foregroundColor(.red)
                                        }
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
