import SwiftUI
import Dater
import Selene

extension Cal {
    struct Ring: View {
        weak var observatory: Observatory!
        let month: [Days<Journal>.Item]
        private let moonImage = Image("MoonMini")
        private let shadowImage = Image("ShadowMini")
        
        var body: some View {
            Canvas { context, size in
                let radius = min(size.width, size.height) * 0.5
                let center = CGPoint(x: size.width / 2, y: size.height / 2)
                let rad = Double.pi2 / .init(month.count)
                let half = rad / 2
                let start = -(.pi_2 - 0.01)
                let end = (start + rad) - 0.02
                var rotation = -(rad + half)
                
                month
                    .forEach { day in
                        rotation += rad
                        let date = day.content.date
                        
                        context.translateBy(x: center.x, y: center.y)
                        context.rotate(by: .radians(rotation))
                        context.translateBy(x: -center.x, y: -center.y)
                        
                        if date <= .now {
                            context.stroke(.init {
                                $0.addArc(center: center,
                                          radius: radius - 31,
                                          startAngle: .radians(start),
                                          endAngle: .radians(end),
                                          clockwise: false)
                            }, with: .color(.accentColor.opacity(day.today ? 1 : 0.25)),
                                           style: .init(lineWidth: 56, lineCap: .butt))
                            
                            context.stroke(.init {
                                $0.addArc(center: center,
                                          radius: radius - 45,
                                          startAngle: .radians(start),
                                          endAngle: .radians(end),
                                          clockwise: false)
                            }, with: .color(.init("Path").opacity(day.today ? 0.5 : 0.25)),
                                           style: .init(lineWidth: 28, lineCap: .butt))
                            
                        } else if date >= Calendar.global.date(byAdding: .day, value: 1, to: .now)! {
                            context.stroke(.init {
                                $0.move(to: .init(x: center.x, y: center.y - 90))
                                $0.addLine(to: .init(x: center.x, y: center.y - radius))
                            }, with: .color(.primary.opacity(0.3)),
                                           style: .init(lineWidth: 1, dash: [1, 3, 3, 5]))
                        }

                        context.translateBy(x: center.x, y: center.y)
                        context.rotate(by: .radians(half))
                        context.translateBy(x: -center.x, y: -center.y)

                        context.drawLayer { con in
                            let center = CGPoint(x: center.x, y: center.y - radius + 18)
                            
                            con.translateBy(x: center.x, y: center.y)
                            con.rotate(by: .radians(-rotation))
                            con.translateBy(x: -center.x, y: -center.y)
                            con.opacity = date <= .now ? 1 : 0.65
                            con.draw(moon: observatory.moon(for: date),
                                         image: moonImage,
                                         shadow: shadowImage,
                                         radius: 7,
                                     center: center)
                        }

                        context.draw(Text(day.value.formatted())
                                        .font(.system(size: 11).monospacedDigit())
                                        .foregroundColor(date <= .now ? .primary : .secondary),
                                     at: .init(x: center.x, y: center.y - radius + 46))

                        context.translateBy(x: center.x, y: center.y)
                        context.rotate(by: .radians(-(rotation + half)))
                        context.translateBy(x: -center.x, y: -center.y)
                    }
            }
            .frame(width: 320, height: 320)
        }
    }
}
