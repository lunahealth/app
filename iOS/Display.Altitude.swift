import SwiftUI
import Selene

extension Display {
    struct Altitude: View {
        let moon: Moon
        
        var body: some View {
            Canvas { context, size in
                context.draw(Text("N"), at: .init(x: size.width / 2, y: (size.height / 2) - 165))
                context
                    .stroke(.init {
                        $0.addArc(center: .init(x: size.width / 2, y: size.height / 2),
                                  radius: 150,
                                  startAngle: .degrees(0),
                                  endAngle: .degrees(360),
                                  clockwise: true)
                    }, with: .color(.black), style: .init(lineWidth: 1))

                context.fill(.init {

                    let p = CGMutablePath()
                    p.addArc(center: .init(x: size.width / 2, y: size.height / 2),
                             radius: 150,
                             startAngle: moon.altitude,
                             endAngle: moon.altitude,
                             clockwise: true)
                    let point = p.currentPoint
                    $0.addArc(center: point,
                              radius: 10,
                              startAngle: .degrees(0),
                              endAngle: .degrees(360),
                              clockwise: false)

                }, with: .color(.blue))
            }
        }
    }
}
