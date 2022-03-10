import SwiftUI
import Selene

extension Track {
    struct Detail: View {
        let status: Track.Status
        let trait: Trait
        let animation: Namespace.ID
        
        var body: some View {
            Button {
                withAnimation(.easeInOut(duration: 0.4)) {
                    status.trait = nil
                }
            } label: {
                VStack(spacing: 0) {
                    Image(systemName: trait.symbol)
                        .matchedGeometryEffect(id: "\(trait).image", in: animation)
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                    ZStack {
                        Capsule()
                            .fill(trait.color)
                            .matchedGeometryEffect(id: "\(trait).capsule", in: animation)
                            .modifier(ShadowedHard())
                        Text(trait.title)
                            .matchedGeometryEffect(id: "\(trait).text", in: animation)
                            .font(.callout.weight(.medium))
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.1)
                    }
                    .frame(width: 110, height: 30)
                    .padding(.top, 8)
                    .padding(.bottom)
                }
            }
            
            HStack(spacing: 0) {
                ForEach(Level.allCases, id: \.self) { level in
                    Item(status: status, trait: trait, level: level, animation: animation)
                }
            }
            .padding(.vertical, 40)
            
            Button {
                Task {
                    await cloud.remove(trait: trait)
                }
                
                withAnimation(.easeInOut(duration: 0.4)) {
                    status.trait = nil
                }
            } label: {
                Text("Cancel")
                    .font(.callout)
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding(.top)
        }
    }
}
