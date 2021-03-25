//
//  DetailView.swift
//  TestApp
//
//  Created by Luis Alessandro Vitte Soto on 25/03/2021.
//

import SwiftUI
import CoreData

struct DetailView: View {
    
    var item: Item

    var body: some View {
        List {
            Section(header: Text("Comment")) {
                Text(item.wrappedComment)
            }
            
            Section (header: Text("Date")) {
                Text((item.date.addingTimeInterval(600)), style: .date)
            }
            
        }.listStyle(InsetGroupedListStyle())
        
        .navigationTitle(item.wrappedName)
        
    }
}
