import SwiftUI
import Selene

extension Home {
    struct Render: View {
        @State var current: CGPoint
        let moon: Moon
        let navigator: any Navigator
        @State private var trail = [CGPoint]()
        private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        
        var body: some View {
            Canvas { context, size in
                trail
                    .forEach { point in
                        context.fill(.init {
                            $0.addArc(center: point,
                                      radius: Moonhealth.Render.regular.radius,
                                      startAngle: .degrees(0),
                                      endAngle: .degrees(360),
                                      clockwise: false)
                        }, with: .color(.accentColor.opacity(0.02)))
                    }

                context.draw(moon: moon,
                             render: .regular,
                             center: current)
            }
            .onReceive(timer) { _ in
                if navigator.origin != current {
                    trail.append(current)
                    current = navigator.approach(from: current)
                }
                
                if navigator.origin == current || trail.count > 35 {
                    if !trail.isEmpty {
                        trail.removeFirst()
                    }
                }
            }
        }
    }
}
