//
//  AddTrasaction.swift
//  BudgetTracker
//
//  Created by admin on 28/01/25.

import SwiftUI

struct AddTrasaction: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var amount = ""
    @State private var desc = ""
    @State private var category = "income"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transaction Details")) {
                    TextField("Enter amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue.opacity(0.3),lineWidth: 1)
                        )
                        .padding(.vertical,4)
                    
                    TextField("Enter description", text: $desc)
                        .keyboardType(.decimalPad)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue.opacity(0.5),lineWidth: 1)
                        )
                        .padding(.vertical,4)
                    
                    Picker("Category", selection: $category) {
                        Text("Income").tag("income").foregroundColor(.green)
                        Text("Expense").tag("expense").foregroundColor(.red)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }.navigationBarTitle("Add New Transaction", displayMode: .inline)
                .navigationBarItems(
                    leading: Button("Cancel") {
                        dismiss()
                    },
                    trailing: Button("Save") {
                        addTransaction()
                        dismiss()
                    }
                    .disabled(amount.isEmpty || desc.isEmpty)
                )
            
        }
    }
    
    private func addTransaction() {
        let newTransaction = Trasaction(context: viewContext)
        
        newTransaction.id = UUID()
        newTransaction.desc = desc
        newTransaction.category = category
        
        if let isDouble = Double(amount) {
            newTransaction.amount = isDouble
        } else {
            newTransaction.amount = 0.0
        }
        
        do {
            try viewContext.save()
            desc = ""
            amount = ""
            category = ""
        } catch {
            print("Error saving transaction: \(error)")
        }
    }
}

struct AddTrasaction_Previews: PreviewProvider {
    static var previews: some View {
        AddTrasaction()
    }
}
