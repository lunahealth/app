import SwiftUI
import Selene

extension Track {
    struct Category: View {
        @ObservedObject var status: Track.Status
        let trait: Trait
        let animation: Namespace.ID
        @Environment(\.colorScheme) private var scheme
        
        var body: some View {
            Button {
                withAnimation(.easeInOut(duration: 0.4)) {
                    status.trait = trait
                }
            } label: {
                VStack(spacing: 4) {
                    ZStack {
                        if let level = status.journal?.traits[trait] {
                            Capsule()
                                .fill(Color(white: 0, opacity: scheme == .dark ? 1 : 0.3))
                                .frame(width: 94, height: 42)
                                .modifier(ShadowedHard())
                            Capsule()
                                .fill(trait.color)
                                .matchedGeometryEffect(id: "\(trait).capsule", in: animation)
                                .frame(width: 92, height: 40)
                            HStack(spacing: 0) {
                                Image(systemName: trait.symbol)
                                    .matchedGeometryEffect(id: "\(trait).image", in: animation)
                                    .font(.system(size: 13).weight(.medium))
                                    .frame(width: 35)
                                Image(systemName: level.symbol)
                                    .matchedGeometryEffect(id: "\(trait).\(level).symbol", in: animation)
                                    .font(.system(size: 13).weight(.medium))
                                    .frame(width: 35)
                            }
                            .padding(.horizontal, 10)
                            .foregroundColor(.white)
                        } else {
                            Circle()
                                .stroke(trait.color, style: .init(lineWidth: 2))
                                .frame(width: 42, height: 42)
                                .modifier(ShadowedHard())
                            Circle()
                                .fill(Color(white: 0, opacity: scheme == .dark ? 1 : 0.5))
                                .matchedGeometryEffect(id: "\(trait).capsule", in: animation)
                                .frame(width: 40, height: 40)
                            Image(systemName: trait.symbol)
                                .matchedGeometryEffect(id: "\(trait).image", in: animation)
                                .font(.system(size: 13).weight(.medium))
                                .foregroundColor(.white)
                        }
                    }
                    Text(trait.title)
                        .font(.caption.weight(.medium))
                        .foregroundStyle(status.journal?.traits[trait] == nil ? .secondary : .primary)
                        .zIndex(-1)
                }
                .padding(.vertical, 7)
            }
            .foregroundColor(.white)
            .id(trait)
        }
    }
}
