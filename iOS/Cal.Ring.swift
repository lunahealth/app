import SwiftUI
import Dater
import Selene

private let side = 340.0
private let radius = side / 2
private let center = CGPoint(x: radius, y: radius)
private let frames = 40.0

extension Cal {
    struct Ring: View, Equatable {
        weak var observatory: Observatory!
        let month: [Days<Journal>.Item]
        @State private var selection = 0
        @State private var detail = false
        private let moonImage = Image("MoonMini")
        private let shadowImage = Image("ShadowMini")
        private let dates = (0 ... .init(frames)).reduce(into: ([Date](), Date.now.timeIntervalSince1970)) {
            $0.0.append(Date(timeIntervalSince1970: $0.1 + (.init($1) / 40)))
        }.0
        
        var body: some View {
            TimelineView(.explicit(dates)) { timeline in
                Canvas { context, size in
                    let index = CGFloat(dates.firstIndex(of: timeline.date)!) + 1
                    let percent = index / frames
                    let half = radPerItem / 2
                    let start = -(.pi_2 - 0.005)
                    let end = (start + radPerItem) - 0.01
                    var rotation = -(radPerItem + half)

                    month
                        .prefix(.init(.init(month.count) * percent))
                        .forEach { day in
                            rotation += radPerItem
                            let date = day.content.date
                            
                            context.translateBy(x: center.x, y: center.y)
                            context.rotate(by: .radians(rotation))
                            context.translateBy(x: -center.x, y: -center.y)
                            
                            if selection == day.value {
                                context.stroke(.init {
                                    $0.addArc(center: center,
                                              radius: (radius / 2) - 1.5,
                                              startAngle: .radians(start),
                                              endAngle: .radians(end),
                                              clockwise: false)
                                }, with: .color(.accentColor),
                                               style: .init(lineWidth: radius - 3, lineCap: .butt))
                                
                                context.stroke(.init {
                                    $0.addArc(center: center,
                                              radius: radius - 45,
                                              startAngle: .radians(start),
                                              endAngle: .radians(end),
                                              clockwise: false)
                                }, with: .color(.white),
                                               style: .init(lineWidth: 28, lineCap: .butt))
                            } else if date <= .now {
                                if day.today {
                                    context.stroke(.init {
                                        $0.addArc(center: center,
                                                  radius: radius - 31,
                                                  startAngle: .radians(start),
                                                  endAngle: .radians(end),
                                                  clockwise: false)
                                    }, with: .color(.accentColor.opacity(0.7)),
                                                   style: .init(lineWidth: 56, lineCap: .butt))
                                    
                                    context.stroke(.init {
                                        $0.addArc(center: center,
                                                  radius: radius - 45,
                                                  startAngle: .radians(start),
                                                  endAngle: .radians(end),
                                                  clockwise: false)
                                    }, with: .color(.accentColor.opacity(0.6)),
                                                   style: .init(lineWidth: 28, lineCap: .butt))
                                } else {
                                    context.stroke(.init {
                                        $0.addArc(center: center,
                                                  radius: radius - 31,
                                                  startAngle: .radians(start),
                                                  endAngle: .radians(end),
                                                  clockwise: false)
                                    }, with: .color(.accentColor.opacity(0.2)),
                                                   style: .init(lineWidth: 56, lineCap: .butt))
                                    
                                    context.stroke(.init {
                                        $0.addArc(center: center,
                                                  radius: radius - 45,
                                                  startAngle: .radians(start),
                                                  endAngle: .radians(end),
                                                  clockwise: false)
                                    }, with: .color(.init("Path").opacity(0.15)),
                                                   style: .init(lineWidth: 28, lineCap: .butt))
                                }
                            } else {
                                context.stroke(.init {
                                    $0.move(to: .init(x: center.x, y: center.y))
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
                                con.opacity = date <= .now ? 1 : 0.45
                                con.draw(moon: observatory.moon(for: date),
                                             image: moonImage,
                                             shadow: shadowImage,
                                             radius: 8,
                                         center: center)
                            }

                            context.draw(Text(day.value.formatted())
                                            .font(.system(size: 11).monospacedDigit())
                                            .foregroundColor(
                                                selection == day.value
                                                ? .black
                                                : date <= .now
                                                    ? .primary
                                                    : .init(.tertiaryLabel)),
                                         at: .init(x: center.x, y: center.y - radius + 46))

                            context.translateBy(x: center.x, y: center.y)
                            context.rotate(by: .radians(-(rotation + half)))
                            context.translateBy(x: -center.x, y: -center.y)
                        }
                }
            }
            .frame(width: side, height: side)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { point in
                        guard validate(point: point.location) else {
                            selection = 0
                            return
                        }
                        
                        let index = item(for: point.location)
                        
                        guard month[index].content.date <= .now else {
                            selection = 0
                            return
                        }
                        
                        selection = month[index].value
                    }
                    .onEnded { point in
                        guard
                            validate(point: point.location),
                            selection > 0
                        else {
                            selection = 0
                            return
                        }
                        detail = true
                    }
            )
            .sheet(isPresented: $detail) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    selection = 0
                }
            } content: {
                Month(selection: $selection,
                      observatory: observatory,
                      month: month.filter { $0.content.date <= .now })
                    .equatable()
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
        
        private func validate(point: CGPoint) -> Bool {
            let distanceX = pow(point.x - center.x, 2)
            let distanceY = pow(center.y - point.y, 2)
            return distanceX + distanceY < 27_000
        }
        
        private var radPerItem: Double {
            .pi2 / .init(month.count)
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.month == rhs.month && lhs.selection == rhs.selection
        }
    }
}
