//
//  BudgetTrackerApp.swift
//  BudgetTracker
//
//  Created by admin on 27/01/25.
//

import SwiftUI

@main
struct BudgetTrackerApp: App {
    let persistentController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistentController.container.viewContext)
        }
        
    }
}



    
