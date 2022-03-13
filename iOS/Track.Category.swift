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
                withAnimation(.easeInOut(duration: 0.3)) {
                    status.trait = trait
                }
            } label: {
                VStack(spacing: 4) {
                    ZStack {
                        if let level = status.journal?.traits[trait] {
                            Capsule()
                                .fill(Color(white: 0, opacity: scheme == .dark ? 1 : 0.3))
                                .frame(width: 96, height: 44)
                                .modifier(Shadowed(level: .medium))
                            Capsule()
                                .fill(trait.color)
                                .matchedGeometryEffect(id: "\(trait).capsule", in: animation)
                                .frame(width: 94, height: 42)
                            HStack(spacing: 0) {
                                Image(systemName: trait.symbol)
                                    .matchedGeometryEffect(id: "\(trait).image", in: animation)
                                    .font(.system(size: 14).weight(.medium))
                                    .frame(width: 37)
                                Image(systemName: level.symbol)
                                    .matchedGeometryEffect(id: "\(trait).\(level).symbol", in: animation)
                                    .font(.system(size: 14).weight(.medium))
                                    .frame(width: 37)
                            }
                            .padding(.horizontal, 10)
                            .foregroundColor(.white)
                        } else {
                            Circle()
                                .stroke(trait.color, style: .init(lineWidth: 2))
                                .frame(width: 43, height: 43)
                                .modifier(Shadowed(level: .medium))
                            Circle()
                                .fill(Color(white: 1, opacity: scheme == .dark ? 0.3 : 0.2))
                                .matchedGeometryEffect(id: "\(trait).capsule", in: animation)
                                .frame(width: 41, height: 41)
                            Image(systemName: trait.symbol)
                                .matchedGeometryEffect(id: "\(trait).image", in: animation)
                                .font(.system(size: 14).weight(.medium))
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
