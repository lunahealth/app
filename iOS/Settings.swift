import SwiftUI

struct Settings: View {
    @State private var location = false
    @State private var traits = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Personalize") {
                    Option(title: "Location",
                           subtitle: "Accurately keep track of the Moon",
                           symbol: "location") {
                        location = true
                    }
                    .sheet(isPresented: $location, content: Location.init)
                    
                    Option(title: "Traits",
                           subtitle: "Your tracking preferences",
                           symbol: "slider.vertical.3") {
                        traits = true
                    }
                    .sheet(isPresented: $traits, content: Traits.init)
                }
                .headerProminence(.increased)
                
                Section("Features") {

                }
                .headerProminence(.increased)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .listStyle(.insetGrouped)
            .task {
                let model = await cloud.model
                if model.settings.traits.isEmpty {
                    traits = true
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
