import SwiftUI
import Selene

struct Analysis: View, Equatable {
    let observatory: Observatory
    @State private var since = Analysing.all
    @State private var traits = [Trait]()
    @State private var analysis = [Trait : [Moon.Phase : Level]]()
    @State private var trait: Trait?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color(.tertiarySystemBackground)
                    .shadow(color: .black.opacity(scheme == .dark ? 1 : 0.15), radius: 3)
                if let trait = trait, let analysis = analysis[trait] {
                    Chart(trait: trait, value: analysis)
                        .equatable()
                        .id(analysis)
                }
            }
            .frame(height: 230)
            .zIndex(1)
            HStack(spacing: 0) {
                ForEach(traits, id: \.self) { item in
                    Button {
                        trait = item
                    } label: {
                        Image(systemName: item.symbol)
                            .font(.system(size: 13))
                            .foregroundColor(item == trait ? .white : .secondary)
                            .contentShape(Rectangle())
                            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
                    }
                    .background(item == trait ? Color.accentColor : .clear)
                }
            }
            .frame(height: 50)
            .background(Color(white: 0, opacity: scheme == .dark ? 0.2 : 0.04))
            Rectangle()
                .fill(Color(white: 0, opacity: scheme == .dark ? 0.3 : 0.1))
                .frame(height: 1)
            Picker("Since", selection: $since) {
                Text("All")
                    .tag(Analysing.all)
                Text("Last month")
                    .tag(Analysing.month)
            }
            .pickerStyle(.segmented)
            .padding()
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
        .onChange(of: since) { value in
            Task {
                await update(since: value)
            }
        }
        .task {
            traits = await cloud.model.settings.traits.sorted()
            await update(since: since)
            trait = traits.first
        }
    }
    
    private func update(since: Analysing) async {
        analysis = await cloud
            .analysis(since: since) {
                observatory.moon(for: $0).phase
            }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
