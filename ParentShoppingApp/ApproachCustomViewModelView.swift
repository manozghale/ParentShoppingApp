import SwiftUI
import ShoppingListModule

struct ApproachCustomViewModelView: View {
    @State private var viewModel: ShoppingListViewModel?
    @State private var error: Error?

    var body: some View {
        Group {
            if let viewModel = viewModel {
                ShoppingListView(viewModel: viewModel)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Sync") {
                                Task { await viewModel.sync() }
                            }
                            .disabled(viewModel.isSyncing)
                        }
                    }
                    
            } else if let error = error {
                ErrorDisplayView(error: error)
            } else {
                ProgressView("Loading...")
            }
        }
        .task { await loadViewModel() }
    }

    @MainActor
    private func loadViewModel() async {
        do {
            print("MainActor view model")
            // let config = ShoppingListConfiguration.development
            let config = ShoppingListConfiguration(apiBaseURL: nil, enableBackgroundSync: true, maxRetries: 3, isTestMode: false)
            viewModel = try await ShoppingListModule.createViewModel(configuration: config)
        } catch {
            self.error = error
        }
    }
}

#Preview {
    ApproachCustomViewModelView()
}


