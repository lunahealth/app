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
                    .frame(width: 52, height: 140)
                    .modifier(ShadowedHard())
                VStack(spacing: 0) {
                    Image(systemName: level.symbol)
                        .matchedGeometryEffect(id: "\(trait).\(level).symbol", in: animation)
                        .font(.system(size: 20).weight(.medium))
                        .frame(height: 60)
                    Image(systemName: trait.symbol)
                        .matchedGeometryEffect(id: "\(trait).image", in: animation)
                        .font(.system(size: 24))
                        .frame(height: 60)
                }
                .foregroundColor(.white)
                .padding(.vertical, 10)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                    withAnimation(.easeInOut(duration: 0.45)) {
                        status.level = nil
                        status.trait = nil
                    }
                }
            }
            Text(trait.title)
                .matchedGeometryEffect(id: "\(trait).text", in: animation)
                .font(.callout.weight(.medium))
                .minimumScaleFactor(0.1)
                .padding(.top)
        }
    }
}
