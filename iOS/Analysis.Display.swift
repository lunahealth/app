import SwiftUI
import Selene

extension Analysis {
    struct Display: View {
        let analysis: [Trait : [Moon.Phase : Level]]
        let trait: Trait?
        @Environment(\.colorScheme) private var scheme
        
        var body: some View {
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
        }
    }
}
