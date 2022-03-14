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
                withAnimation(.easeInOut(duration: 0.3)) {
                    status.level = level
                }
            } label: {
                VStack(spacing: 0) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 52, height: 52)
                            .modifier(Shadowed(level: .medium))
                        if selected {
                            Circle()
                                .fill(Color.accentColor)
                                .frame(width: 48, height: 48)
                        }
                        Image(systemName: level.symbol)
                            .matchedGeometryEffect(id: "\(trait).\(level).symbol", in: animation)
                            .font(.system(size: 18).weight(.medium))
                            .foregroundColor(selected ? .white : .black)
                    }
                    Text(level.title(for: trait))
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(selected ? .primary : .secondary)
                        .foregroundColor(.white)
                        .padding(.top, 3)
                        .zIndex(-1)
                }
                .frame(width: 70)
            }
        }
        
        var selected: Bool {
            status.journal?.traits[trait] == level
        }
    }
}
