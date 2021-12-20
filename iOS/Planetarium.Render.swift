import SwiftUI
import Selene

private let radius = 74.0
private let radius2 = radius + radius

extension Planetarium {
    struct Render: View {
        let moon: Moon
        private let image = Image("Moon")
        
        var body: some View {
            Canvas { context, size in
                
                let center = CGPoint(x: size.width / 2, y: 200)
                
                context.fill(.init {
                    $0.move(to: center)
                    $0.addArc(center: center,
                              radius: 75,
                              startAngle: .degrees(0),
                              endAngle: .degrees(360),
                              clockwise: false)
                    $0.closeSubpath()
                }, with: .color(.init(.quaternarySystemFill)))
                
                switch moon.phase {
                case .new:
                    context.clip(to: .init {
                        $0.move(to: center)
                        $0.addArc(center: center,
                                  radius: radius,
                                  startAngle: .degrees(0),
                                  endAngle: .degrees(0),
                                  clockwise: false)
                        $0.closeSubpath()
                    })
                
                case .waxingCrescent:
                    let top = CGPoint(x: center.x, y: center.y - radius)
                    let delta = radius2 * (1 - (.init(moon.fraction) / 50.0))
                    let vertical = delta / 1.5
                    
                    context.clip(to: .init {
                        $0.move(to: top)
                        $0.addArc(center: center,
                                  radius: radius,
                                  startAngle: .degrees(-90),
                                  endAngle: .degrees(90),
                                  clockwise: false)
                        $0.addCurve(to: top,
                                    control1: .init(x: center.x + delta, y: center.y + vertical),
                                    control2: .init(x: center.x + delta, y: center.y - vertical))
                    })
                    
                case .firstQuarter:
                    context.clip(to: .init {
                        $0.move(to: center)
                        $0.addArc(center: center,
                                  radius: radius,
                                  startAngle: .degrees(-90),
                                  endAngle: .degrees(90),
                                  clockwise: false)
                        $0.closeSubpath()
                    })
                    
                case .waxingGibbous:
                    let delta = radius2 * (1 - (.init(moon.fraction) / 100.0))
                                 
                    context.clip(to: .init {
                        $0.move(to: center)
                        $0.addEllipse(in: .init(
                            x: center.x - radius + delta,
                            y: center.y - radius - delta,
                            width: radius2,
                            height: radius2 + delta * 2))
                        $0.closeSubpath()
                    })
                    
                default:
                    break
                }
                
                context.draw(image, at: center)
            }
        }
    }

}
