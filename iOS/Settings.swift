import SwiftUI

struct Settings: View {
    let status: Status
    
    var body: some View {
        NavigationView {
            List {
                
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .onReceive(cloud.first()) {
                if $0.settings.traits.isEmpty {
                    status.modal = .onboard
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
