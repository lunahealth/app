import SwiftUI
import Selene

struct Track: View {
    @State private var traits = [Trait]()
    @State private var journal: Journal?
    
    var body: some View {
        NavigationView {
            if traits.isEmpty {
                VStack {
                    Text("Set your preferences\nto start tracking")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    Image(systemName: "arrow.right")
                        .font(.callout.weight(.medium))
                        .padding(.top)
                }
            } else {
                ScrollView {
                    if !traits.isEmpty && traits.count <= (journal?.traits.count ?? 0) {
                        Label("Completed!", systemImage: "checkmark.circle.fill")
                            .font(.callout)
                            .imageScale(.large)
                            .padding(.vertical)
                    }
                    
                    ForEach(traits, id: \.self) { trait in
                        Item(journal: $journal, trait: trait)
                    }
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
