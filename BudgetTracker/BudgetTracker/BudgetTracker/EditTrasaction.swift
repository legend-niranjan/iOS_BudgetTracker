//
//  EditTrasaction.swift
//  BudgetTracker
//
//  Created by admin on 29/01/25.
//

import SwiftUI

struct EditTrasaction: View {
    @Environment(\.managedObjectContext) private var viewContext
       @Environment(\.dismiss) private var dismiss

       @ObservedObject var transaction: Trasaction
        @State private var amount=""
       @State private var desc = ""
        @State private var category = ""

       var body: some View {
           NavigationView {
               Form {
                   Section(header: Text("Edit Transaction")) {
                       TextField("Edit amount", text: $amount).padding()
                       TextField("Edit description", text: $desc).padding()
                       Picker("Category", selection: $category) {
                           Text("Income").tag("income").foregroundColor(.green)
                           Text("Expense").tag("expense").foregroundColor(.red)
                       }
                       .pickerStyle(SegmentedPickerStyle())
                   }
               }
               .navigationBarTitle("Edit Transaction", displayMode: .inline)
               .navigationBarItems(
                   leading: Button("Cancel") {
                       dismiss()
                   },
                   trailing: Button("Update") {
                       transaction.desc = desc
                       transaction.category=category
                       saveContext()
                       dismiss()
                   }.disabled(desc.isEmpty)
               )
               .onAppear {
                   amount = String(format: "%.2f", transaction.amount)
                   desc = transaction.desc ?? ""
                   category=transaction.category ?? ""
               }
           }
       }

       private func saveContext() {
           do {
               try viewContext.save()
           } catch {
               print("Error saving context: \(error)")
           }
       }
   
}

