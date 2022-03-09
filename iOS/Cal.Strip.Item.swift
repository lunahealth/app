import SwiftUI
import Dater
import Selene

extension Cal.Strip {
    struct Item: View {
        @Binding var day: Int
        let today: Days<Journal>.Item
        let moon: Moon
        let point = CGPoint(x: 26, y: 23)
        @Environment(\.colorScheme) private var scheme
        
        var body: some View {
            Canvas { context, size in
                if day == today.value {
                    context.fill(.init {
                        $0.addArc(center: point,
                                  radius: 20,
                                  startAngle: .radians(0),
                                  endAngle: .radians(.pi2),
                                  clockwise: true)
                    }, with: .color(scheme == .dark ? .black : .accentColor.opacity(0.7)))
                    
                    context.draw(moon: moon,
                                 render: .small,
                                 center: point)
                } else {
                    context.fill(.init {
                        $0.addArc(center: point,
                                  radius: 10,
                                  startAngle: .radians(0),
                                  endAngle: .radians(.pi2),
                                  clockwise: true)
                    }, with: .color(scheme == .dark ? .black : .accentColor.opacity(0.7)))
                    
                    context.draw(moon: moon,
                                 render: .mini,
                                 center: point)
                }
            }
            .opacity(day == today.value ? 1 : 0.5)
            .frame(width: 52, height: 48)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.4)) {
                    day = today.value
                }
            }
        }
    }
}
