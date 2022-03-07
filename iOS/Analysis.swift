import SwiftUI
import Selene

struct Analysis: View, Equatable {
    let observatory: Observatory
    @State private var since = Defaults.currentSince
    @State private var traits = [Trait]()
    @State private var analysis = [Trait : [Moon.Phase : Level]]()
    @State private var trait: Trait?
    @State private var stats: Stats?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            Display(analysis: analysis, trait: trait)
            Strip(trait: $trait, traits: traits)
            
            Picker("Since", selection: $since) {
                Text("All")
                    .tag(Analysing.all)
                Text("Month")
                    .tag(Analysing.month)
                Text("Fortnight")
                    .tag(Analysing.fortnight)
            }
            .pickerStyle(.segmented)
            .padding([.top, .trailing, .leading])
            
            if let trait = trait, let stats = stats {
                Info(trait: trait, stats: stats)
                    .animation(.easeInOut(duration: 0.3), value: stats)
                    .padding(.horizontal, 30)
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.down.circle.fill")
                    .font(.system(size: 32).weight(.light))
                    .symbolRenderingMode(.hierarchical)
                    .frame(width: 40, height: 40)
                    .contentShape(Rectangle())
            }
            .padding(.bottom)
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
