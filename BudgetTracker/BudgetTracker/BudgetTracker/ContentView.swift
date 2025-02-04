//
//  ContentView.swift
//  BudgetTracker
//
//  Created by admin on 27/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
