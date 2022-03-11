import SwiftUI
import Selene

extension Track.Detail {
    struct Item: View {
        @ObservedObject var status: Track.Status
        let trait: Trait
        let level: Level
        let animation: Namespace.ID
        @Environment(\.colorScheme) private var scheme
        
        var body: some View {
            Button {
                Task {
                    await cloud.track(trait: trait, level: level)
                }
                withAnimation(.easeInOut(duration: 0.45)) {
                    status.level = level
                }
            } label: {
                VStack(spacing: 0) {
                    ZStack {
                        Circle()
                            .fill(Color(white: 0, opacity: scheme == .dark ? 1 : 0.3))
                            .frame(width: 48, height: 48)
                            .modifier(ShadowedHard())
                        Circle()
                            .fill(selected ? Color.accentColor : .white)
                            .matchedGeometryEffect(id: "\(trait).\(level).circle", in: animation)
                            .frame(width: 46, height: 46)
                        Image(systemName: level.symbol)
                            .matchedGeometryEffect(id: "\(trait).\(level).symbol", in: animation)
                            .font(.system(size: 16).weight(.medium))
                            .foregroundColor(selected ? .white : .black)
                    }
                    Text(level.title(for: trait))
                        .font(.caption2.weight(.medium))
                        .foregroundStyle(selected ? .primary : .secondary)
                        .foregroundColor(.white)
                        .padding(.top, 3)
                        .zIndex(-1)
                }
                .frame(width: 64)
            }
        }
        
        var selected: Bool {
            status.journal?.traits[trait] == level
        }
    }
}
