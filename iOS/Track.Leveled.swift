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
                    .fill(Color.white)
                    .frame(width: 110, height: 49)
                    .modifier(Shadowed(level: .medium))
                Capsule()
                    .fill(trait.color)
                    .matchedGeometryEffect(id: "\(trait).capsule", in: animation)
                    .frame(width: 106, height: 45)
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        status.level = nil
                        status.trait = nil
                    }
                }
            }
        }
    }
}
