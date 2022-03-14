import SwiftUI
import Selene

private let fontSize = 16.0

extension Track {
    struct Category: View {
        @ObservedObject var status: Track.Status
        let trait: Trait
        let animation: Namespace.ID
        @Environment(\.colorScheme) private var scheme
        
        var body: some View {
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    status.trait = trait
                }
            } label: {
                VStack(spacing: 4) {
                    ZStack {
                        if let level = status.journal?.traits[trait] {
                            Capsule()
                                .fill(Color.white)
                                .frame(width: 100, height: 48)
                                .modifier(Shadowed(level: .medium))
                            Capsule()
                                .fill(trait.color)
                                .matchedGeometryEffect(id: "\(trait).capsule", in: animation)
                                .frame(width: 96, height: 44)
                            HStack(spacing: 0) {
                                Image(systemName: trait.symbol)
                                    .matchedGeometryEffect(id: "\(trait).image", in: animation)
                                    .font(.system(size: fontSize).weight(.medium))
                                    .frame(width: 39)
                                Image(systemName: level.symbol)
                                    .matchedGeometryEffect(id: "\(trait).\(level).symbol", in: animation)
                                    .font(.system(size: fontSize).weight(.medium))
                                    .frame(width: 39)
                            }
                            .padding(.horizontal, 10)
                            .foregroundColor(.white)
                        } else {
                            Circle()
                                .stroke(trait.color, style: .init(lineWidth: 2))
                                .frame(width: 47, height: 47)
                                .modifier(Shadowed(level: .medium))
                            Circle()
                                .fill(trait.color.opacity(0.4))
                                .matchedGeometryEffect(id: "\(trait).capsule", in: animation)
                                .frame(width: 45, height: 45)
                            Image(systemName: trait.symbol)
                                .matchedGeometryEffect(id: "\(trait).image", in: animation)
                                .font(.system(size: fontSize).weight(.medium))
                                .foregroundColor(.white)
                        }
                    }
                    Text(trait.title)
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(status.journal?.traits[trait] == nil ? .secondary : .primary)
                        .zIndex(-1)
                }
            }
            .foregroundColor(.white)
            .id(trait)
        }
    }
}
