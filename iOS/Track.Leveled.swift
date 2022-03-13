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
                    .fill(trait.color)
                    .matchedGeometryEffect(id: "\(trait).capsule", in: animation)
                    .frame(width: 100, height: 45)
                    .modifier(Shadowed(level: .medium))
                HStack(spacing: 0) {
                    Image(systemName: trait.symbol)
                        .matchedGeometryEffect(id: "\(trait).image", in: animation)
                        .font(.system(size: 18).weight(.bold))
                        .frame(width: 40)
                    Image(systemName: level.symbol)
                        .matchedGeometryEffect(id: "\(trait).\(level).symbol", in: animation)
                        .font(.system(size: 18).weight(.bold))
                        .frame(width: 40)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 10)
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
