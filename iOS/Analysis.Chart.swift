import SwiftUI
import Selene

private let frames = 50.0

extension Analysis {
    struct Chart: View, Equatable {
        let trait: Trait
        let value: [Moon.Phase : Level]
        @Environment(\.colorScheme) private var scheme
        
        private let dates = (0 ... .init(frames)).reduce(into: ([Date](), Date.now.timeIntervalSince1970)) {
            $0.0.append(Date(timeIntervalSince1970: $0.1 + (.init($1) / 50)))
        }.0
        
        var body: some View {
            TimelineView(.explicit(dates)) { timeline in
                Canvas { context, size in
                    let index = CGFloat(dates.firstIndex(of: timeline.date)!) + 1
                    let percent = index / frames
                    let vertical = (size.height - 30) / .init(Level.allCases.count)
                    let horizontal = (size.width - 90) / .init(Moon.Phase.allCases.count - 1)
                    var ys = [Level : CGFloat]()
                    var y = size.height - (vertical - 10)
                    
                    Level
                        .allCases
                        .forEach { level in
                            let point = CGPoint(x: 28, y: y)
                            
                            context.fill(.init {
                                $0.addArc(center: point,
                                          radius: 12,
                                          startAngle: .radians(0),
                                          endAngle: .radians(.pi2),
                                          clockwise: true)
                            }, with: .color(scheme == .dark ? .black : .accentColor.opacity(0.15)))
                            
                            context.draw(Text(Image(systemName: level.symbol))
                                            .font(.system(size: 10).weight(.medium))
                                            .foregroundColor(.primary), at: point)
                            ys[level] = y
                            y -= vertical
                        }
                    
                    guard index > 1 else { return }
                    
                    var points = [(Moon.Phase, CGPoint)]()
                    var x = CGFloat(65)
                    var previous = CGPoint.zero
                    
                    context.stroke(.init { path in
                        Moon
                            .Phase
                            .allCases
                            .forEach { phase in
                                guard let y = value[phase].flatMap({ ys[$0] }) else { return }
                                
                                let point = CGPoint(x: x, y: y)
                                
                                if points.isEmpty {
                                    path.move(to: point)
                                } else {
                                    path.addCurve(to: point,
                                                  control1: .init(
                                                    x: point.x,
                                                    y: previous.y),
                                                  control2: .init(
                                                    x: previous.x,
                                                    y: point.y))
                                }
                                previous = point
                                points.append((phase, point))
                                x += horizontal
                            }
                        path = path.trimmedPath(from: 0, to: percent)
                    }, with: .color(scheme == .dark ? .primary : .accentColor), style: .init(lineWidth: 1, lineCap: .round, lineJoin: .round))

                    guard percent > 0 else { return }
                    
                    points
                        .prefix(.init(ceil(.init(points.count) * percent)))
                        .forEach { point in
                            context.blendMode = .clear
                            
                            context.fill(.init {
                                $0.addArc(center: point.1,
                                          radius: 11,
                                          startAngle: .radians(0),
                                          endAngle: .radians(.pi2),
                                          clockwise: true)
                            }, with: .backdrop)
                            
                            context.blendMode = .normal
                            
                            context.fill(.init {
                                $0.addArc(center: point.1,
                                          radius: 9,
                                          startAngle: .radians(0),
                                          endAngle: .radians(.pi2),
                                          clockwise: true)
                            }, with: .color(scheme == .dark ? .black : .accentColor.opacity(0.6)))
                            
                            context
                                .drawLayer { layer in
                                    layer.draw(phase: point.0,
                                               render: .mini,
                                               center: point.1)
                                }
                        }
                }
            }
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            true
        }
    }
}
