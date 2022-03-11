import SwiftUI
import Dater
import Selene

extension Cal.Strip {
    struct Item: View {
        @Binding var day: Int
        let item: Days<Journal>.Item
        let moon: Moon
        private let point = CGPoint(x: 26, y: 32)
        @Environment(\.colorScheme) private var scheme
        
        var body: some View {
            Button {
                withAnimation(.easeInOut(duration: 0.4)) {
                    day = item.value
                }
            } label: {
                Canvas { context, size in
                    if day == item.value {
                        context.fill(.init {
                            $0.addRect(.init(origin: .zero, size: .init(width: 52, height: 64)))
                        }, with: .color(.init(white: 0, opacity: scheme == .dark ? 0.3 : 0.05)))
                        
                        context.fill(.init {
                            $0.addArc(center: point,
                                      radius: 19,
                                      startAngle: .radians(0),
                                      endAngle: .radians(.pi2),
                                      clockwise: true)
                        }, with: .color(.init(white: 0, opacity: scheme == .dark ? 1 : 0.2)))
                        
                        context.draw(moon: moon,
                                     render: .small,
                                     center: point)
                    } else {
                        context.fill(.init {
                            $0.addArc(center: point,
                                      radius: 9,
                                      startAngle: .radians(0),
                                      endAngle: .radians(.pi2),
                                      clockwise: true)
                        }, with: .color(.init(white: 0, opacity: scheme == .dark ? 1 : 0.2)))
                        
                        context.draw(moon: moon,
                                     render: .mini,
                                     center: point)
                    }
                }
                .contentShape(Rectangle())
            }
            .frame(width: 52, height: 64)
        }
    }
}
