import SwiftUI
import Selene

extension Cal {
    struct Ring: View {
        weak var observatory: Observatory!
        let dates = Array(repeating: Date(), count: 31)
        private let moonImage = Image("MoonMini")
        private let shadowImage = Image("ShadowMini")
        
        var body: some View {
            Canvas { context, size in
                let radius = min(size.width, size.height) * 0.43
                let center = CGPoint(x: size.width / 2, y: size.height / 2)
                
                context.stroke(.init {
                    $0.addArc(center: center,
                              radius: radius - 33,
                              startAngle: .radians(0),
                              endAngle: .radians(.pi2 + 0.1),
                              clockwise: false)
                }, with: .color(.accentColor.opacity(0.35)), style: .init(lineWidth: 58))

                context.stroke(.init {
                    $0.addArc(center: center,
                              radius: radius - 47,
                              startAngle: .radians(0),
                              endAngle: .radians(.pi2 + 0.1),
                              clockwise: false)
                }, with: .color(.init("Path").opacity(0.3)), style: .init(lineWidth: 30))

                let rad = Double.pi2 / .init(dates.count)
                let half = rad / 2
                
                dates
                    .enumerated()
                    .forEach { date in
                        let rotation = rad * .init(date.0)

                        context.translateBy(x: center.x, y: center.y)
                        context.rotate(by: .radians(rotation))
                        context.translateBy(x: -center.x, y: -center.y)

                        context.stroke(.init {
                            $0.move(to: .init(x: center.x, y: center.y - 120))
                            $0.addLine(to: .init(x: center.x, y: center.y - radius))
                        }, with: .color(.primary.opacity(0.4)), style: .init(lineWidth: 1, dash: [1, 3, 3, 5]))

                        context.translateBy(x: center.x, y: center.y)
                        context.rotate(by: .radians(half))
                        context.translateBy(x: -center.x, y: -center.y)

                        context.drawLayer { con in
                            con.draw(moon: observatory.moon(for: .now),
                                         image: moonImage,
                                         shadow: shadowImage,
                                         radius: 10,
                                     center: .init(x: center.x, y: center.y - radius + 18))
                        }

                        context.draw(Text((date.0 + 1).formatted())
                                        .font(.system(size: 12).monospacedDigit()), at: .init(x: center.x, y: center.y - radius + 46))

                        context.translateBy(x: center.x, y: center.y)
                        context.rotate(by: .radians(-(rotation + half)))
                        context.translateBy(x: -center.x, y: -center.y)
                    }
            }
        }
    }
}
