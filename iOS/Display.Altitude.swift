import SwiftUI
import Selene

private let pi_2 = Double.pi / 2

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

                if moon.azimuth >= -pi_2  && moon.azimuth <= pi_2 {
                    context.fill(.init {
                        $0.addArc(center: .init(x: (size.width / 2) - (moon.azimuth / pi_2 * 150),
                                                y: (size.height / 2) + (moon.altitude > (pi_2 / 2) ? -(moon.altitude / pi_2 * 150) : (moon.altitude / pi_2 * 150))),
                                  radius: 10,
                                  startAngle: .degrees(0),
                                  endAngle: .degrees(360),
                                  clockwise: false)

                    }, with: .color(.blue))
                }
            }
        }
    }
}
