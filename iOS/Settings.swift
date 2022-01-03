import SwiftUI

struct Settings: View {
    let status: Status
    
    var body: some View {
        NavigationView {
            List {
                Section("Personalize") {
                    Button("Preferences") {
                        status.modal = .onboard
                    }
                }
                .headerProminence(.increased)
                
                Section("Features") {

                }
                .headerProminence(.increased)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .listStyle(.insetGrouped)
            .onReceive(cloud.first()) {
                if $0.settings.traits.isEmpty {
                    status.modal = .onboard
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
