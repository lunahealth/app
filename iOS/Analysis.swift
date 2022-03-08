import SwiftUI
import Selene

struct Analysis: View, Equatable {
    let observatory: Observatory
    @State private var since = Defaults.currentSince
    @State private var traits = [Trait]()
    @State private var analysis = [Trait : [Moon.Phase : Level]]()
    @State private var stats = [Stats]()
    @State private var trait: Trait?
    
    var body: some View {
        VStack(spacing: 0) {
            Display(since: $since, analysis: analysis, trait: trait)
            Strip(trait: $trait, traits: traits)
            
            if let trait = trait {
                Info(trait: trait, stats: stats)
                    .padding(.top)
                    .animation(.easeInOut(duration: 0.3), value: stats)
            }
            Spacer()
        }
        .background(Color(.secondarySystemBackground))
        .onChange(of: trait) { value in
            Defaults.currentTrait = value
            
            Task {
                await update(trait: value)
            }
        }
        .onChange(of: since) { value in
            Defaults.currentSince = value
            Task {
                await update(since: value)
            }
        }
        .task {
            await update(since: since)
            traits = await cloud.model.settings.traits.sorted()
            trait = Defaults
                .currentTrait
                .flatMap {
                    traits.contains($0) ? $0 : nil
                } ?? traits.first
            await update(trait: trait)
        }
    }
    
    private func update(since: Analysing) async {
        analysis = await cloud
            .analysis(since: since) {
                observatory.moon(for: $0).phase
            }
    }
    
    private func update(trait: Trait?) async {
        guard let trait = trait else { return }
        stats = await cloud
            .stats(trait: trait)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
