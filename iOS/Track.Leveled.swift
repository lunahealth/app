import SwiftUI
import Selene

extension Track {
    struct Leveled: View {
        weak var status: Status!
        let trait: Trait
        let level: Level
        let animation: Namespace.ID
        
        var body: some View {
            VStack(spacing: 20) {
                Spacer()
                Image(systemName: trait.symbol)
                    .matchedGeometryEffect(id: "\(trait).image", in: animation)
                    .font(.largeTitle.weight(.light))
                    .foregroundColor(trait.color)
                Text(trait.title)
                    .matchedGeometryEffect(id: "\(trait).text", in: animation)
                    .font(.title3)
                    .minimumScaleFactor(0.1)
                Track.Item(trait: trait, level: level, selected: true, animation: animation)
                    .font(.largeTitle.weight(.light))
                    .frame(width: 70, height: 70)
                Spacer()
            }
            .frame(maxWidth: .greatestFiniteMagnitude)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    status.previous = status.trait
                    withAnimation(.easeInOut(duration: 0.35)) {
                        status.level = nil
                        status.trait = nil
                    }
                }
            }
        }
    }
}
