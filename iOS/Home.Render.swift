import SwiftUI
import Selene

extension Home {
    struct Render: View {
        let moon: Moon
        let wheel: Wheel
        @State var current: CGPoint
        private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        
        var body: some View {
            Canvas { context, size in
                context.draw(moon: moon,
                             image: .init("Moon"),
                             shadow: .init("Shadow"),
                             radius: 34,
                             center: current)
            }
            .onReceive(timer) { _ in
                if wheel.origin != current {
                    current = wheel.approach(from: current)
                }
            }
        }
    }
}
