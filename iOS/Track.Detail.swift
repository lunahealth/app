import SwiftUI
import Selene

extension Track {
    struct Detail: View {
        let trait: Trait
        let animation: Namespace.ID
        let back: () -> Void
        
        var body: some View {
            ZStack {
                HStack {
                    Button(action: back) {
                        Image(systemName: "arrow.backward.circle.fill")
                            .font(.system(size: 26).weight(.light))
                            .symbolRenderingMode(.hierarchical)
                            .frame(width: 40, height: 40)
                            .padding(.leading)
                    }
                    Spacer()
                }
                HStack {
                    Image(systemName: trait.image)
                        .resizable()
                        .matchedGeometryEffect(id: "\(trait).image", in: animation)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 18)
                        .foregroundColor(trait.color)
                    Text(trait.title)
                        .matchedGeometryEffect(id: "\(trait).text", in: animation)
                        .font(.footnote)
                }
            }
            .padding(.top)
            
            Spacer()
        }
    }
}
