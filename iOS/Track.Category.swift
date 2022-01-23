import SwiftUI
import Selene

extension Track {
    struct Category: View {
        let trait: Trait
        let animation: Namespace.ID
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.thinMaterial)
                    Image(systemName: "checkmark.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                        .font(.system(size: 25).weight(.light))
                        .padding([.top, .trailing], 5)
                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topTrailing)
                    Text(trait.title)
                        .matchedGeometryEffect(id: "\(trait).text", in: animation)
                        .font(.footnote)
                        .padding(.bottom, 10)
                        .frame(maxHeight: .greatestFiniteMagnitude, alignment: .bottom)
                    Image(systemName: trait.image)
                        .resizable()
                        .matchedGeometryEffect(id: "\(trait).image", in: animation)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .foregroundColor(trait.color)
                }
                .frame(width: 140, height: 140)
            }
            .id(trait)
        }
    }
}
