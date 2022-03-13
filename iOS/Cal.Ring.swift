import SwiftUI
import Dater
import Selene

private let pad = 20.0
private let size = 340.0
private let radius = size / 2
private let center = CGPoint(x: radius, y: radius + pad)
private let frames = 50.0

extension Cal {
    struct Ring: View {
        @Binding var day: Int
        let observatory: Observatory
        let month: [Days<Journal>.Item]
        @Environment(\.colorScheme) private var scheme
        private let dates = (0 ... .init(frames)).reduce(into: ([Date](), Date.now.timeIntervalSince1970)) {
            $0.0.append(Date(timeIntervalSince1970: $0.1 + 0.1 + (.init($1) / 40)))
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
                        .forEach { item in
                            rotation += radPerItem
                            
                            context.translateBy(x: center.x, y: center.y)
                            context.rotate(by: .radians(rotation))
                            context.translateBy(x: -center.x, y: -center.y)
                            
                            if day == item.value {
                                context.stroke(.init {
                                    $0.addArc(center: center,
                                              radius: radius - 36,
                                              startAngle: .radians(start + 0.08),
                                              endAngle: .radians(end - 0.08),
                                              clockwise: false)
                                }, with: .color(.accentColor),
                                               style: .init(lineWidth: 62, lineCap: .butt))
                            } else if item.content.date <= .now {
                                if item.today {
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
                                                  radius: radius - 45,
                                                  startAngle: .radians(start),
                                                  endAngle: .radians(end),
                                                  clockwise: false)
                                    }, with: .color(.accentColor.opacity(0.2)),
                                                   style: .init(lineWidth: 28, lineCap: .butt))
                                }
                            } else {
                                context.stroke(.init {
                                    $0.move(to: .init(x: center.x, y: center.y - (radius - 60)))
                                    $0.addLine(to: .init(x: center.x, y: center.y - (radius - 30)))
                                }, with: .color(.primary.opacity(0.6)),
                                               style: .init(lineWidth: 1, dash: [1, 3]))
                            }

                            context.translateBy(x: center.x, y: center.y)
                            context.rotate(by: .radians(half))
                            context.translateBy(x: -center.x, y: -center.y)

                            if day != item.value {
                                if item.content.date <= .now {
                                    context.drawLayer { con in
                                        let center = CGPoint(x: center.x, y: center.y - radius + 18)
                                        con.translateBy(x: center.x, y: center.y)
                                        con.rotate(by: .radians(-rotation))
                                        con.translateBy(x: -center.x, y: -center.y)
                                        con.draw(moon: observatory.moon(for: item.content.date),
                                                 render: .mini,
                                                 center: center)
                                    }
                                }

                                context.draw(Text(item.value, format: .number)
                                                .font(.system(size: 11).monospacedDigit())
                                                .foregroundColor(
                                                    day == item.value
                                                    ? .black
                                                    : item.content.date <= .now
                                                        ? .primary
                                                        : .secondary),
                                             at: .init(x: center.x, y: center.y - radius + 46))
                            }

                            context.translateBy(x: center.x, y: center.y)
                            context.rotate(by: .radians(-(rotation + half)))
                            context.translateBy(x: -center.x, y: -center.y)
                            
                            if day == item.value {
                                context.drawLayer {
                                    $0.fill(.init {
                                        $0.addArc(center: center,
                                                  radius: 19,
                                                  startAngle: .radians(0),
                                                  endAngle: .radians(.pi2),
                                                  clockwise: true)
                                    }, with: .color(.init(white: 0, opacity: scheme == .dark ? 1 : 0.2)))
                                    
                                    $0.draw(moon: observatory.moon(for: item.content.date),
                                                 render: .regular,
                                                 center: center)
                                }
                            }
                        }
                }
            }
            .frame(width: size, height: size + pad + pad)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { point in
                        guard validate(point: point.location) else { return }
                        let index = item(for: point.location)
                        
                        guard month[index].content.date <= .now else { return }
                        day = month[index].value
                    }
            )
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
            return distanceX + distanceY < 30_000
        }
        
        private var radPerItem: Double {
            .pi2 / .init(month.count)
        }
    }
}
