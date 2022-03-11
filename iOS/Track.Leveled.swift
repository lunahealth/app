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
                    .frame(width: 45, height: 100)
                    .modifier(ShadowedHard())
                VStack(spacing: 0) {
                    Image(systemName: level.symbol)
                        .matchedGeometryEffect(id: "\(trait).\(level).symbol", in: animation)
                        .font(.system(size: 18).weight(.bold))
                        .frame(height: 40)
                    Image(systemName: trait.symbol)
                        .matchedGeometryEffect(id: "\(trait).image", in: animation)
                        .font(.system(size: 18).weight(.bold))
                        .frame(height: 40)
                }
                .foregroundColor(.white)
                .padding(.vertical, 10)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        status.level = nil
                        status.trait = nil
                    }
                }
            }
        }
    }
}
