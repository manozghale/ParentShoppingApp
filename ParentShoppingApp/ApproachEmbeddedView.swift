import SwiftUI
import ShoppingListModule

struct ApproachEmbeddedView: View {
    @State private var viewModel: ShoppingListViewModel?
    @State private var showAddItem = false

    var body: some View {
        VStack(spacing: 0) {
            header

            if let viewModel = viewModel {
                ShoppingListView(viewModel: viewModel)
            } else {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .task { await loadViewModel() }
        .sheet(isPresented: $showAddItem) { Text("Add Item UI here") }
    }

    private var header: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: "cart.fill").foregroundColor(.blue)
                Text("Shopping List").font(.title2).fontWeight(.semibold)
                Spacer()
                Button(action: { showAddItem = true }) {
                    Image(systemName: "plus.circle.fill").foregroundColor(.blue).font(.title2)
                }
            }
            ProgressView(value: completedCount, total: totalCount)
                .tint(.blue)
            HStack {
                Text("\(Int(completedCount)) of \(Int(totalCount)) completed")
                    .font(.caption).foregroundColor(.secondary)
                Spacer()
                Text("\(percentageText)")
                    .font(.caption).fontWeight(.medium)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .shadow(color: .black.opacity(0.1), radius: 2, y: 1)
    }

    private var completedCount: Double { Double(viewModel?.items.filter { $0.isBought }.count ?? 0) }
    private var totalCount: Double { Double(viewModel?.items.count ?? 0) }
    private var percentageText: String {
        let total = max(totalCount, 1)
        let value = Int((completedCount / total) * 100)
        return "\(value)%"
    }

    @MainActor
    private func loadViewModel() async {
        do {
            viewModel = try await ShoppingListModule.createViewModel(configuration: .development)
        } catch {
            // Swallow for demo
        }
    }
}

#Preview {
    ApproachEmbeddedView()
}


