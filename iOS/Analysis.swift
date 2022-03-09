import SwiftUI
import Selene

private let display = 260.0

struct Analysis: View, Equatable {
    let observatory: Observatory
    @State private var since = Defaults.currentSince
    @State private var traits = [Trait]()
    @State private var analysis = [Trait : [Moon.Phase : Level]]()
    @State private var stats = [Stats]()
    @State private var trait: Trait?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                ZStack(alignment: .top) {
                    Color(.tertiarySystemBackground)
                    if let trait = trait, let analysis = analysis[trait] {
                        Chart(trait: trait, value: analysis)
                            .equatable()
                            .id(analysis)
                    }
                }
                .frame(height: display)
                .zIndex(-1)
                Color(.secondarySystemBackground)
                    .edgesIgnoringSafeArea(.bottom)
            }
            ScrollView {
                VStack(spacing: 0) {
                    Strip(trait: $trait, traits: traits)
                    Spacer()
                        .frame(height: 20)
                    Picker("Since", selection: $since) {
                        Text("All")
                            .tag(Analysing.all)
                        Text("Month")
                            .tag(Analysing.month)
                        Text("Fortnight")
                            .tag(Analysing.fortnight)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 280)
                    Spacer()
                        .frame(height: 30)
                    if let trait = trait {
                        Info(trait: trait, stats: stats)
                            .animation(.easeInOut(duration: 0.3), value: stats)
                    }
                    Spacer()
                        .frame(height: 30)
                }
                .background(Color(.secondarySystemBackground))
                .padding(.top, display)
            }
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 22))
                    .symbolRenderingMode(.hierarchical)
                    .frame(width: 50, height: 50)
                    .contentShape(Rectangle())
                    .foregroundColor(.secondary)
            }
        }
        .onChange(of: trait) { value in
            Defaults.currentTrait = value
            
            Task {
                await update(since: since, trait: value)
            }
        }
        .onChange(of: since) { value in
            Defaults.currentSince = value
            Task {
                await update(since: value)
                await update(since: since, trait: trait)
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
            await update(since: since, trait: trait)
        }
    }
    
    private func update(since: Analysing) async {
        analysis = await cloud
            .analysis(since: since) {
                observatory.moon(for: $0).phase
            }
    }
    
    private func update(since: Analysing, trait: Trait?) async {
        guard let trait = trait else { return }
        stats = await cloud
            .stats(since: since, trait: trait)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
