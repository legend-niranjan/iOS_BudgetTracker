//
//  TrasactionListView.swift
//  BudgetTracker
//
//  Created by admin on 28/01/25.
//

import SwiftUI
import CoreData

struct TransactionListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Trasaction.entity(),
        sortDescriptors: []
    ) private var transactions: FetchedResults<Trasaction>
    
    @State private var showAddView = false
    @State private var postToEdit: Trasaction?
    
    var balance: Double {
            transactions.reduce(0) { result, transaction in
                if transaction.category == "income" {
                    return result + transaction.amount
                } else if transaction.category == "expense" {
                    return result - transaction.amount
                }
                return result
            }
        }
    
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Text("Balance:").font(.title)
                    Text("₹\(balance, specifier: "%.2f")").font(.title).foregroundColor(balance>0 ?.green: .red)
                            .padding()
                }
               
                List {
                    ForEach(transactions) { transaction in
                        NavigationLink(destination: EditTrasaction(transaction: transaction)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(transaction.desc ?? "No Description").font(.headline).bold()
                                        .foregroundColor(.blue)
                                    Text(transaction.category ?? "No category")
                                        .font(.headline)
                                }
                                Spacer()
                                Text("\(transaction.amount, specifier: "%.2f")").font(.headline)
                                    .foregroundColor(transaction.category == "income" ? .green: .red)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteTransaction(transaction)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("All Transactions")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddView) {
                AddTrasaction()
            }
        }
    }
    
    private func deleteTransaction(_ transaction: Trasaction) {
        viewContext.delete(transaction)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting transaction: \(error)")
        }
    }
    
   
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
    }
}

