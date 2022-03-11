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
                ZStack {
                    Circle()
                        .fill(trait.color)
                        .matchedGeometryEffect(id: "\(trait).capsule", in: animation)
                        .modifier(ShadowedHard())
                    Image(systemName: trait.symbol)
                        .matchedGeometryEffect(id: "\(trait).image", in: animation)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                }
                .frame(width: 48, height: 48)
                .padding(.bottom)
            }
            
            HStack(spacing: 0) {
                ForEach(Level.allCases, id: \.self) { level in
                    Item(status: status, trait: trait, level: level, animation: animation)
                }
            }
            .padding(.vertical)
            
            Button {
                Task {
                    await cloud.remove(trait: trait)
                }
                
                withAnimation(.easeInOut(duration: 0.4)) {
                    status.trait = nil
                }
            } label: {
                Text("Cancel")
                    .font(.callout.weight(.medium))
            }
            .foregroundStyle(.secondary)
            .foregroundColor(.white)
            .tint(.white)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding(.top)
        }
    }
}
