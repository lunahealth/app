import SwiftUI
import Selene

extension Track.Header {
    struct Option: View {
        let day: Day
        let current: Bool
        
        var body: some View {
            VStack {
                Canvas { context, size in
                    context.draw(moon: day.moon,
                                 image: .init("MoonSmall"),
                                 shadow: .init("ShadowSmall"),
                                 radius: 13,
                                 center: .init(x: size.width / 2, y: size.height / 2))
                }
                .frame(width: 30, height: 30)
                .opacity(current ? 1 : 0.3)
                Text(day.id, format: current ? .dateTime.weekday(.short).day() : .dateTime.day())
                    .font(current ? .caption : .caption2)
                    .foregroundColor(current ? .primary : .secondary)
            }
        }
    }
}
