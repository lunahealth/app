import SwiftUI
import Selene

extension GraphicsContext {
    mutating func draw(phase: Moon.Phase, render: Render, center: CGPoint) {
        draw(phase: phase,
             angle: phase.angle,
             fraction: phase.fraction,
             render: render,
             center: center)
    }
    
    mutating func draw(moon: Moon, render: Render, center: CGPoint) {
        draw(phase: moon.phase, angle: moon.angle, fraction: moon.fraction, render: render, center: center)
    }
    
    private mutating func draw(phase: Moon.Phase,
                               angle: Double,
                               fraction: Int,
                               render: Render,
                               center: CGPoint) {
        translateBy(x: center.x, y: center.y)
        rotate(by: .radians(.pi_2 - angle))
        translateBy(x: -center.x, y: -center.y)
        
        if render.blur {
            drawLayer { layer in
                layer.addFilter(.blur(radius: render.radius / 3))
                
                layer
                    .fill(.init {
                        $0.addArc(center: center,
                                  radius: render.radius,
                                  startAngle: .radians(0),
                                  endAngle: .radians(.pi2),
                                  clockwise: false)
                    }, with: .color(.accentColor))
            }
        }
        
        switch phase {
        case .new:
            draw(render.shadow.antialiased(true), at: center)
            clip(to: .init {
                $0.addArc(center: center,
                          radius: render.radius,
                          startAngle: .degrees(0),
                          endAngle: .degrees(0),
                          clockwise: false)
            })
        case .waxingGibbous, .waningGibbous:
            draw(render.shadow.antialiased(true), at: center)
            let bottom = CGPoint(x: center.x, y: center.y + render.radius)
            let delta = render.radius * (1 - (.init(fraction) / 50.0))
            let horizontal = delta * 1.25
            let vertical = delta / 1.25
            
            clip(to: .init {
                $0.move(to: bottom)
                $0.addArc(center: center,
                          radius: render.radius,
                          startAngle: .degrees(90),
                          endAngle: .degrees(-90),
                          clockwise: false)
                $0.addCurve(to: bottom,
                            control1: .init(x: center.x - horizontal, y: center.y + vertical),
                            control2: .init(x: center.x - horizontal, y: center.y - vertical))
            })
            draw(render.image.antialiased(true), at: center)
        case .firstQuarter, .lastQuarter:
            draw(render.shadow.antialiased(true), at: center)
            clip(to: .init {
                $0.addArc(center: center,
                          radius: render.radius,
                          startAngle: .degrees(90),
                          endAngle: .degrees(-90),
                          clockwise: false)
            })
            draw(render.image.antialiased(true), at: center)
        case .waxingCrescent, .waningCrescent:
            draw(render.shadow.antialiased(true), at: center)
            let bottom = CGPoint(x: center.x, y: center.y + render.radius)
            let delta = render.radius * (1 - (.init(fraction) / 50.0))
            let horizontal = delta * 1.25
            let vertical = delta / 1.25
            
            clip(to: .init {
                $0.move(to: bottom)
                $0.addArc(center: center,
                          radius: render.radius,
                          startAngle: .degrees(90),
                          endAngle: .degrees(-90),
                          clockwise: false)
                $0.addCurve(to: bottom,
                            control1: .init(x: center.x - horizontal, y: center.y - vertical),
                            control2: .init(x: center.x - horizontal, y: center.y + vertical))
            })
            draw(render.image.antialiased(true), at: center)
        default:
            clip(to: .init {
                $0.addArc(center: center,
                          radius: render.radius,
                          startAngle: .degrees(0),
                          endAngle: .degrees(360),
                          clockwise: false)
            })
            draw(render.image.antialiased(true), at: center)
        }
    }
}

private extension Moon.Phase {
    var angle: Double {
        switch self {
        case .waxingCrescent, .firstQuarter:
            return -.pi_2
        case .waningCrescent, .lastQuarter:
            return .pi_2
        case .waxingGibbous:
            return -.pi_2
        case .waningGibbous:
            return .pi_2
        default:
            return 0
        }
    }
    
    var fraction: Int {
        switch self {
        case .waxingCrescent, .waningCrescent:
            return 25
        case .waxingGibbous, .waningGibbous:
            return 74
        default:
            return 0
        }
    }
}
