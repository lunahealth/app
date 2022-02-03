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
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(status.journal?.traits[trait] == nil ? .primary : .primary)
                        .foregroundColor(status.journal?.traits[trait] == nil ? .init(.tertiarySystemBackground) : .accentColor)
                        .shadow(color: .black.opacity(0.3), radius: 4)
                    if let level = status.journal?.traits[trait] {
                        VStack(alignment: .trailing) {
                            Track.Item(trait: trait, level: level, selected: true, animation: animation)
                                .font(.system(size: 15).weight(.medium))
                                .frame(width: 25, height: 25)
                                .padding([.top, .trailing], 10)
                            Spacer()
                        }
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                    }
                    Text(trait.title)
                        .matchedGeometryEffect(id: "\(trait).text", in: animation)
                        .font(.footnote)
                        .foregroundColor(.primary)
                        .padding(.bottom, 10)
                        .frame(maxHeight: .greatestFiniteMagnitude, alignment: .bottom)
                    Image(systemName: trait.symbol)
                        .matchedGeometryEffect(id: "\(trait).image", in: animation)
                        .font(.title2.weight(.light))
                        .foregroundColor(status.journal?.traits[trait] == nil ? trait.color : .primary)
                        .shadow(color: .black.opacity(status.journal?.traits[trait] == nil ? 1 : 0), radius: 0.5)
                }
                .frame(width: 130, height: 130)
            }
            .foregroundColor(.secondary)
            .id(trait)
        }
    }
}
