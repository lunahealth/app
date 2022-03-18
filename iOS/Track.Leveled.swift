import SwiftUI
import Selene

extension Track {
    struct Leveled: View {
        let status: Status
        let trait: Trait
        let level: Level
        let animation: Namespace.ID
        
        var body: some View {
            ZStack {
                Capsule()
                    .stroke(trait.color, style: .init(lineWidth: 2))
                    .frame(width: 110, height: 54)
                    .modifier(Shadowed(level: .medium))
                Capsule()
                    .fill(trait.color.opacity(0.7))
                    .matchedGeometryEffect(id: "\(trait).capsule", in: animation)
                    .frame(width: 108, height: 52)
                HStack(spacing: 0) {
                    Image(systemName: trait.symbol)
                        .matchedGeometryEffect(id: "\(trait).image", in: animation)
                        .font(.system(size: 20).weight(.bold))
                        .frame(width: 45)
                    Image(systemName: level.symbol)
                        .matchedGeometryEffect(id: "\(trait).\(level).symbol", in: animation)
                        .font(.system(size: 20).weight(.bold))
                        .frame(width: 45)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 5)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        status.level = nil
                        status.trait = nil
                    }
                }
            }
        }
    }
}
