import SwiftUI
import Selene

extension Track {
    struct Detail: View {
        let status: Track.Status
        let trait: Trait
        let animation: Namespace.ID
        
        var body: some View {
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    status.trait = nil
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(trait.color)
                        .matchedGeometryEffect(id: "\(trait).capsule", in: animation)
                        .modifier(Shadowed(level: .medium))
                    Image(systemName: trait.symbol)
                        .matchedGeometryEffect(id: "\(trait).image", in: animation)
                        .font(.system(size: 20).weight(.medium))
                        .foregroundColor(.white)
                }
                .frame(width: 58, height: 58)
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
                
                withAnimation(.easeInOut(duration: 0.3)) {
                    status.trait = nil
                }
            } label: {
                Text("Cancel")
                    .font(.callout.weight(.medium))
                    .padding(.horizontal, 3)
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
