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
                                .fill(Color(.tertiarySystemBackground))
                                .frame(width: 92, height: 42)
                                .shadow(color: .black.opacity(scheme == .dark ? 1 : 0.4), radius: 4)
                            HStack(spacing: 0) {
                                Image(systemName: trait.symbol)
                                    .matchedGeometryEffect(id: "\(trait).image", in: animation)
                                    .font(.system(size: 13))
                                    .frame(width: 35)
                                Image(systemName: level.symbol)
                                    .matchedGeometryEffect(id: "\(trait).\(level).symbol", in: animation)
                                    .font(.system(size: 15).weight(.medium))
                                    .frame(width: 35)
                            }
                            .padding(.horizontal, 10)
                            .foregroundColor(.secondary)
                        } else {
                            Circle()
                                .fill(scheme == .dark ? .black : Color.accentColor)
                                .frame(width: 42, height: 42)
                                .shadow(color: .black.opacity(scheme == .dark ? 1 : 0.4), radius: 4)
                            Circle()
                                .fill(trait.color)
                                .frame(width: 40, height: 40)
                            Image(systemName: trait.symbol)
                                .matchedGeometryEffect(id: "\(trait).image", in: animation)
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                        }
                    }
                    Text(trait.title)
                        .matchedGeometryEffect(id: "\(trait).text", in: animation)
                        .font(.caption)
                        .foregroundStyle(status.journal?.traits[trait] == nil ? .primary : .secondary)
                        .zIndex(-1)
                }
                .padding(.vertical, 7)
            }
            .foregroundColor(.secondary)
            .id(trait)
        }
    }
}
