import SwiftUI

struct Settings: View {
    @State private var preferences = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Personalize") {
                    Button("Preferences") {
                        preferences = true
                    }
                    .sheet(isPresented: $preferences, content: Preferences.init)
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
                    preferences = true
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
