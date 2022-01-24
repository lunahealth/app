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
                        .fill(status.journal?.traits[trait] == nil ? .primary : .quaternary)
                        .foregroundColor(status.journal?.traits[trait] == nil ? .init(.tertiarySystemBackground) : .accentColor)
                        .shadow(color: .black.opacity(0.2), radius: status.journal?.traits[trait] == nil ? 3 : 0)
                    if let level = status.journal?.traits[trait] {
                        VStack(alignment: .trailing) {
                            Track.Item(trait: trait, level: level, selected: true, animation: animation)
                                .font(.footnote.weight(.light))
                                .frame(width: 24, height: 24)
                                .padding([.top, .trailing], 6)
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
                        .foregroundColor(trait.color)
                }
                .frame(width: 120, height: 120)
            }
            .foregroundColor(.secondary)
            .id(trait)
        }
    }
}
