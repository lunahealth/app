import SwiftUI
import Selene

extension Display {
    struct Azimuth: View {
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
                             startAngle: moon.azimuth + .pi / 2,
                             endAngle: moon.azimuth + .pi / 2,
                             clockwise: true)
                    let point = p.currentPoint
                    $0.addArc(center: point,
                              radius: 10,
                              startAngle: .degrees(0),
                              endAngle: .degrees(360),
                              clockwise: false)

                }, with: .color(moon.altitude >= 0 ? .blue : .gray))
            }
        }
    }
}
