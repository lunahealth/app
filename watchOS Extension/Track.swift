import SwiftUI
import Selene

struct Track: View {
    @State private var traits = [Trait]()
    @State private var journal: Journal?
    
    var body: some View {
        NavigationView {
            if traits.isEmpty {
                Text("Set your preferences\nto start tracking")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            } else {
                List(traits, id: \.self) { trait in
                    Item(journal: $journal, trait: trait)
                }
                .navigationTitle("Track")
            }
        }
        .onReceive(cloud) { model in
            traits = Trait
                .allCases
                .filter {
                    model.settings.traits.contains($0)
                }
                .sorted()
            
            refresh()
        }
        .onAppear(perform: refresh)
    }
    
    private func refresh() {
        Task {
            journal = await cloud.model[.now]
        }
    }
}
