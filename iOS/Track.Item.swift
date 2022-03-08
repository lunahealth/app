import SwiftUI
import Selene

extension Track {
    struct Item: View {
        let trait: Trait
        let level: Level
        let selected: Bool
        let animation: Namespace.ID
        
        var body: some View {
            ZStack {
                Circle()
                    .fill(.primary)
                    .matchedGeometryEffect(id: "\(trait).\(level).circle", in: animation)
                    .foregroundColor(selected ? .accentColor : .init(.tertiarySystemBackground))
                Image(systemName: level.symbol)
                    .matchedGeometryEffect(id: "\(trait).\(level).symbol", in: animation)
                    .foregroundColor(selected ? .white : .primary)
            }
        }
    }
}
