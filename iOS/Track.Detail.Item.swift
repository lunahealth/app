import SwiftUI
import Selene

extension Track.Detail {
    struct Item: View {
        @ObservedObject var status: Track.Status
        let trait: Trait
        let level: Level
        let animation: Namespace.ID
        
        var body: some View {
            Button {
                Task {
                    await cloud.track(trait: trait, level: level)
                }
                withAnimation(.easeInOut(duration: 0.45)) {
                    status.level = level
                }
            } label: {
                VStack {
                    ZStack {
                        Circle()
                            .fill(.primary)
                            .matchedGeometryEffect(id: "\(trait).\(level).circle", in: animation)
                            .foregroundColor(selected ? .accentColor : .init(.tertiarySystemBackground))
                            .modifier(ShadowedHard())
                        Image(systemName: level.symbol)
                            .matchedGeometryEffect(id: "\(trait).\(level).symbol", in: animation)
                            .font(.system(size: 18).weight(.medium))
                            .foregroundColor(selected ? .white : .primary)
                    }
                    .frame(width: 50, height: 50)
                    Text(level.title(for: trait))
                        .font(.caption2)
                        .foregroundColor(.primary)
                }
                .frame(width: 70)
            }
        }
        
        var selected: Bool {
            status.journal?.traits[trait] == level
        }
    }
}
