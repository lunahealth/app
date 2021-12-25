import SwiftUI
import Selene

private let radius = 34.0
private let radius2 = radius + radius

extension Home {
    struct Render: View {
        let moon: Moon
        let wheel: Wheel
        @State var current: CGPoint
        private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        private let shadow = Image("Shadow")
        private let image = Image("Moon")
        
        var body: some View {
            Canvas { context, size in
                context.translateBy(x: current.x, y: current.y)
                context.rotate(by: .radians(.pi_2 - moon.angle))
                context.translateBy(x: -current.x, y: -current.y)
                
                context.draw(shadow, at: current)
                
                switch moon.phase {
                case .new:
                    context.clip(to: .init {
                        $0.addArc(center: current,
                                  radius: radius,
                                  startAngle: .degrees(0),
                                  endAngle: .degrees(0),
                                  clockwise: false)
                    })
                    
                case .waxingGibbous, .waningGibbous:
                    let bottom = CGPoint(x: current.x, y: current.y + radius)
                    let delta = radius * (1 - (.init(moon.fraction) / 50.0))
                    let horizontal = delta * 1.25
                    let vertical = delta / 1.25
                    
                    context.clip(to: .init {
                        $0.move(to: bottom)
                        $0.addArc(center: current,
                                  radius: radius,
                                  startAngle: .degrees(90),
                                  endAngle: .degrees(-90),
                                  clockwise: false)
                        $0.addCurve(to: bottom,
                                    control1: .init(x: current.x - horizontal, y: current.y + vertical),
                                    control2: .init(x: current.x - horizontal, y: current.y - vertical))
                    })
                    
                case .firstQuarter, .lastQuarter:
                    context.clip(to: .init {
                        $0.addArc(center: current,
                                  radius: radius,
                                  startAngle: .degrees(90),
                                  endAngle: .degrees(-90),
                                  clockwise: false)
                    })
                    
                case .waxingCrescent, .waningCrescent:
                    let bottom = CGPoint(x: current.x, y: current.y + radius)
                    let delta = radius * (1 - (.init(moon.fraction) / 50.0))
                    let horizontal = delta * 1.25
                    let vertical = delta / 1.25
                    
                    context.clip(to: .init {
                        $0.move(to: bottom)
                        $0.addArc(center: current,
                                  radius: radius,
                                  startAngle: .degrees(90),
                                  endAngle: .degrees(-90),
                                  clockwise: false)
                        $0.addCurve(to: bottom,
                                    control1: .init(x: current.x - horizontal, y: current.y - vertical),
                                    control2: .init(x: current.x - horizontal, y: current.y + vertical))
                    })
                    
                default:
                    context.clip(to: .init {
                        $0.addArc(center: current,
                                  radius: radius,
                                  startAngle: .degrees(0),
                                  endAngle: .degrees(360),
                                  clockwise: false)
                    })
                    
                }
                
                context.draw(image, at: current)
            }
            .onReceive(timer) { _ in
                if wheel.origin != current {
                    current = wheel.approach(from: current)
                }
            }
        }
    }
}
