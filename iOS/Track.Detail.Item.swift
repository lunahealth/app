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
                        if selected {
                            Circle()
                                .stroke(trait.color, style: .init(lineWidth: 2))
                                .frame(width: 51, height: 51)
                                .modifier(Shadowed(level: .medium))
                            Circle()
                                .fill(trait.color.opacity(0.4))
                                .frame(width: 50, height: 50)
                        } else {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 52, height: 52)
                                .modifier(Shadowed(level: .medium))
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
