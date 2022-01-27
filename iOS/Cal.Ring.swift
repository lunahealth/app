import SwiftUI
import Dater
import Selene

extension Cal {
    struct Ring: View {
        weak var observatory: Observatory!
        let calendar: [Days<Journal>.Item]
        private let moonImage = Image("MoonMini")
        private let shadowImage = Image("ShadowMini")
        
        var body: some View {
            Canvas { context, size in
                let radius = min(size.width, size.height) * 0.5
                let center = CGPoint(x: size.width / 2, y: size.height / 2)
                
                context.stroke(.init {
                    $0.addArc(center: center,
                              radius: radius - 31,
                              startAngle: .radians(0),
                              endAngle: .radians(.pi2 + 0.1),
                              clockwise: false)
                }, with: .color(.accentColor.opacity(0.35)), style: .init(lineWidth: 56))

                context.stroke(.init {
                    $0.addArc(center: center,
                              radius: radius - 45,
                              startAngle: .radians(0),
                              endAngle: .radians(.pi2 + 0.1),
                              clockwise: false)
                }, with: .color(.init("Path").opacity(0.3)), style: .init(lineWidth: 28))

                let rad = Double.pi2 / .init(calendar.count)
                let half = rad / 2
                var rotation = -rad
                
                calendar
                    .forEach { day in
                        rotation += rad

                        context.translateBy(x: center.x, y: center.y)
                        context.rotate(by: .radians(rotation))
                        context.translateBy(x: -center.x, y: -center.y)

                        context.stroke(.init {
                            $0.move(to: .init(x: center.x, y: center.y - 95))
                            $0.addLine(to: .init(x: center.x, y: center.y - radius))
                        }, with: .color(.primary.opacity(0.4)), style: .init(lineWidth: 1, dash: [1, 3, 3, 5]))

                        context.translateBy(x: center.x, y: center.y)
                        context.rotate(by: .radians(half))
                        context.translateBy(x: -center.x, y: -center.y)

                        context.drawLayer { con in
                            let center = CGPoint(x: center.x, y: center.y - radius + 18)
                            
                            con.translateBy(x: center.x, y: center.y)
                            con.rotate(by: .radians(-rotation))
                            con.translateBy(x: -center.x, y: -center.y)
                            
                            con.draw(moon: observatory.moon(for: day.content.date),
                                         image: moonImage,
                                         shadow: shadowImage,
                                         radius: 7,
                                     center: center)
                        }

                        context.draw(Text(day.value.formatted())
                                        .font(.system(size: 11).monospacedDigit()), at: .init(x: center.x, y: center.y - radius + 46))

                        context.translateBy(x: center.x, y: center.y)
                        context.rotate(by: .radians(-(rotation + half)))
                        context.translateBy(x: -center.x, y: -center.y)
                    }
            }
            .frame(width: 320, height: 320)
        }
    }
}
