import SwiftUI
import Selene

extension Track {
    struct Category: View {
        @ObservedObject var status: Track.Status
        let trait: Trait
        let animation: Namespace.ID
        
        var body: some View {
            Button {
                withAnimation(.easeInOut(duration: 0.4)) {
                    status.trait = trait
                }
            } label: {
                ZStack {
                    Capsule()
                        .fill(.primary)
                        .foregroundColor(status.journal?.traits[trait] == nil ? .init(.tertiarySystemBackground) : .accentColor)
                        .modifier(Shadowed())
                    HStack(spacing: 0) {
                        Image(systemName: trait.symbol)
                            .matchedGeometryEffect(id: "\(trait).image", in: animation)
                            .font(.system(size: 16).weight(.light))
                            .foregroundColor(status.journal?.traits[trait] == nil ? trait.color : .white)
                            .frame(width: 42)
                            .padding(.leading, 8)
                        
                        Text(trait.title)
                            .matchedGeometryEffect(id: "\(trait).text", in: animation)
                            .font(.caption)
                            .foregroundColor(status.journal?.traits[trait] == nil ? .primary : .white)
                            .frame(width: 60, alignment: .center)
                        
                        
                        if let level = status.journal?.traits[trait] {
                            Track.Item(trait: trait, level: level, selected: true, animation: animation)
                                .font(.system(size: 15).weight(.medium))
                                .frame(width: 42)
                                .padding(.trailing, 8)
                        } else {
                            Spacer()
                        }
                    }
                }
                .frame(width: 160, height: 40)
                .padding(.vertical, 6)
            }
            .foregroundColor(.secondary)
            .id(trait)
        }
    }
}
