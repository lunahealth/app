import SwiftUI
import Selene

extension Track {
    struct Detail: View {
        let trait: Trait
        let animation: Namespace.ID
        
        var body: some View {
            HStack {
                Image(systemName: trait.image)
                    .resizable()
                    .matchedGeometryEffect(id: "\(trait).image", in: animation)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 16)
                    .foregroundColor(trait.color)
                Text(trait.title)
                    .matchedGeometryEffect(id: "\(trait).text", in: animation)
                    .font(.footnote)
            }
            .padding(.top, 25)
            
            Spacer()
        }
    }
}
