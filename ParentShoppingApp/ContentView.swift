//
//  ContentView.swift
//  ParentShoppingApp
//
//  Created by Manoj on 10/08/2025.
//

// import SwiftUI
// import ShoppingListModule

// struct ContentView: View {
//     var body: some View {
//         NavigationView {
//             // ✅ NEW: SimpleShoppingListView automatically handles everything
//             SimpleShoppingListView()
//                 .navigationTitle("Shopping List")
//                 .navigationBarTitleDisplayMode(.large)
//         }
//     }
// }

import SwiftUI
import ShoppingListModule

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Select Approach") {
                    NavigationLink("Simple (Module-provided)") {
                        ApproachSimpleView()
                            .navigationTitle("Simple")
                    }
                    NavigationLink("Custom ViewModel (Programmatic)") {
                        ApproachCustomViewModelView()
                            .navigationTitle("Custom VM")
                    }
                    NavigationLink("Tabbed App") {
                        ApproachTabbedView()
                            .navigationTitle("Tabbed")
                    }
                    NavigationLink("Embedded Header + List") {
                        ApproachEmbeddedView()
                            .navigationTitle("Embedded")
                    }
                    
                }
            }
            .navigationTitle("Shopping List Demos")
        }
    }
}

// Custom error view for this app
struct ErrorDisplayView: View {
    let error: Error
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(.red)
            
            Text("Error")
                .font(.headline)
            
            Text(error.localizedDescription)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}