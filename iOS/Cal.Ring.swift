import SwiftUI
import Dater
import Selene

private let side = 340.0
private let radius = side / 2
private let center = CGPoint(x: radius, y: radius)

extension Cal {
    struct Ring: View {
        weak var observatory: Observatory!
        let month: [Days<Journal>.Item]
        @State private var selection = -1
        @State private var detail = false
        private let moonImage = Image("MoonMini")
        private let shadowImage = Image("ShadowMini")
        
        var body: some View {
            Canvas { context, size in
                
                let half = radPerItem / 2
                let start = -(.pi_2 - 0.005)
                let end = (start + radPerItem) - 0.01
                var rotation = -(radPerItem + half)
                
                month
                    .forEach { day in
                        rotation += radPerItem
                        let date = day.content.date
                        
                        context.translateBy(x: center.x, y: center.y)
                        context.rotate(by: .radians(rotation))
                        context.translateBy(x: -center.x, y: -center.y)
                        
                        if date <= .now {
                            if day.today {
                                context.stroke(.init {
                                    $0.addArc(center: center,
                                              radius: radius / 2,
                                              startAngle: .radians(start),
                                              endAngle: .radians(end),
                                              clockwise: false)
                                }, with: .color(.accentColor),
                                               style: .init(lineWidth: radius, lineCap: .butt))
                                
                                context.stroke(.init {
                                    $0.addArc(center: center,
                                              radius: radius - 45,
                                              startAngle: .radians(start),
                                              endAngle: .radians(end),
                                              clockwise: false)
                                }, with: .color(.init(.systemBackground).opacity(0.3)),
                                               style: .init(lineWidth: 28, lineCap: .butt))
                            } else {
                                context.stroke(.init {
                                    $0.addArc(center: center,
                                              radius: radius - 31,
                                              startAngle: .radians(start),
                                              endAngle: .radians(end),
                                              clockwise: false)
                                }, with: .color(.accentColor.opacity(0.25)),
                                               style: .init(lineWidth: 56, lineCap: .butt))
                                
                                context.stroke(.init {
                                    $0.addArc(center: center,
                                              radius: radius - 45,
                                              startAngle: .radians(start),
                                              endAngle: .radians(end),
                                              clockwise: false)
                                }, with: .color(.init("Path").opacity(0.2)),
                                               style: .init(lineWidth: 28, lineCap: .butt))
                            }
                        } else if date >= Calendar.global.date(byAdding: .day, value: 1, to: .now)! {
                            context.stroke(.init {
                                $0.move(to: .init(x: center.x, y: center.y))
                                $0.addLine(to: .init(x: center.x, y: center.y - radius))
                            }, with: .color(.primary.opacity(0.3)),
                                           style: .init(lineWidth: 1, dash: [1, 3, 3, 5]))
                        }
                        
                        if selection >= 0,
                           month[selection] == day {
                            context.stroke(.init {
                                $0.addArc(center: center,
                                          radius: radius / 2,
                                          startAngle: .radians(start),
                                          endAngle: .radians(end),
                                          clockwise: false)
                            }, with: .color(.blue),
                                           style: .init(lineWidth: radius, lineCap: .butt))
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
            .frame(width: side, height: side)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { point in
                        selection = item(for: point.location)
                        detail = true
                    }
            )
            .sheet(isPresented: $detail) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    selection = -1
                }
            } content: {
                Month(selection: $selection, month: month)
            }
        }
        
        private func item(for point: CGPoint) -> Int {
            let originX = point.x - center.x
            let originY = center.y - point.y
            var position = Double(atan2(originX, originY))
            
            if position <= radPerItem / -2 {
                position += .pi2
            }
            
            return min(max(0, Int(round(position / radPerItem))), month.count - 1)
        }
        
        private var radPerItem: Double {
            .pi2 / .init(month.count)
        }
    }
}
