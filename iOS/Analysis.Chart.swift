import SwiftUI
import Selene

private let frames = 35.0

extension Analysis {
    struct Chart: View {
        let trait: Trait
        let value: [Moon.Phase : Level]
        
        private let dates = (0 ... .init(frames)).reduce(into: ([Date](), Date.now.timeIntervalSince1970)) {
            $0.0.append(Date(timeIntervalSince1970: $0.1 + 0.15 + (.init($1) / 50)))
        }.0
        
        var body: some View {
            TimelineView(.explicit(dates)) { timeline in
                Canvas { context, size in
                    
                    let vertical = (size.height - 55) / .init(Level.allCases.count)
                    let horizontal = (size.width - 80) / .init(Moon.Phase.allCases.count - 1)
                    var ys = [Level : CGFloat]()
                    var y = size.height - (vertical + 20)
                    
                    Level
                        .allCases
                        .forEach { level in
                            context.draw(Text(Image(systemName: level.symbol))
                                            .font(.system(size: 12).weight(.light))
                                            .foregroundColor(.primary), at: .init(x: 24, y: y))
                            ys[level] = y
                            y -= vertical
                        }
                    
                    var points = [Moon.Phase : CGPoint]()
                    var x = CGFloat(55)
                    var previous = CGPoint.zero
                    
                    context.stroke(.init { path in
                        Moon
                            .Phase
                            .allCases
                            .forEach { phase in
                                guard let y = value[phase].flatMap({ ys[$0] }) else { return }
                                
                                let point = CGPoint(x: x, y: y)
                                
                                if phase == .new {
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
                                points[phase] = point
                                x += horizontal
                            }
                    }, with: .color(.accentColor), style: .init(lineWidth: 1, lineCap: .round, lineJoin: .round))

                    Moon
                        .Phase
                        .allCases
                        .forEach { phase in
                            guard let point = points[phase] else { return }
                            
                            context.blendMode = .clear
                            
                            context.fill(.init {
                                $0.addArc(center: point,
                                          radius: 6,
                                          startAngle: .radians(0),
                                          endAngle: .radians(.pi2),
                                          clockwise: true)
                            }, with: .backdrop)
                            
                            context.blendMode = .normal
                            
                            context.stroke(.init {
                                $0.addArc(center: point,
                                          radius: 4,
                                          startAngle: .radians(0),
                                          endAngle: .radians(.pi2),
                                          clockwise: true)
                            }, with: .color(.primary.opacity(0.75)), lineWidth: 1)

                            context
                                .drawLayer { layer in
                                    layer.draw(phase: phase,
                                               render: .mini,
                                               center: .init(x: point.x, y: size.height - 22))
                                }
                        }
                }
            }
        }
    }
}
