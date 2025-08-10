import SwiftUI
import ShoppingListModule

struct ApproachTabbedView: View {
    var body: some View {
        TabView {
            ApproachSimpleView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Personal")
                }

            ApproachCustomViewModelView()
                .tabItem {
                    Image(systemName: "cart.badge.plus")
                    Text("Family")
                }

            SettingsDemoView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

private struct SettingsDemoView: View {
    @State private var useMockServices = true
    @State private var enableSync = false

    var body: some View {
        Form {
            Section("Network Configuration") {
                Toggle("Use Mock Services", isOn: $useMockServices)
                Toggle("Enable Sync", isOn: $enableSync)
                    .disabled(useMockServices)
            }

            Section("Data Management") {
                Button("Clear Local Data") {}
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    ApproachTabbedView()
}


