import SwiftUI
import Selene

extension GraphicsContext {
    mutating func draw(phase: Moon.Phase, image: Image, shadow: Image, radius: Double, center: CGPoint) {
        draw(phase: phase,
             angle: phase.angle,
             fraction: phase.fraction,
             image: image,
             shadow: shadow,
             radius: radius,
             center: center)
    }
    
    mutating func draw(moon: Moon, image: Image, shadow: Image, radius: Double, center: CGPoint) {
        draw(phase: moon.phase, angle: moon.angle, fraction: moon.fraction, image: image, shadow: shadow, radius: radius, center: center)
    }
    
    private mutating func draw(phase: Moon.Phase,
                               angle: Double,
                               fraction: Int,
                               image: Image,
                               shadow: Image,
                               radius: Double,
                               center: CGPoint) {
        translateBy(x: center.x, y: center.y)
        rotate(by: .radians(.pi_2 - angle))
        translateBy(x: -center.x, y: -center.y)
        
        stroke(.init {
            $0.addArc(center: center,
                      radius: radius,
                      startAngle: .degrees(0),
                      endAngle: .degrees(360),
                      clockwise: false)
        }, with: .color(.black.opacity(0.3)), lineWidth: 0.5)
        
        draw(shadow, at: center)
        
        switch phase {
        case .new:
            clip(to: .init {
                $0.addArc(center: center,
                          radius: radius,
                          startAngle: .degrees(0),
                          endAngle: .degrees(0),
                          clockwise: false)
            })
            
        case .waxingGibbous, .waningGibbous:
            let bottom = CGPoint(x: center.x, y: center.y + radius)
            let delta = radius * (1 - (.init(fraction) / 50.0))
            let horizontal = delta * 1.25
            let vertical = delta / 1.25
            
            clip(to: .init {
                $0.move(to: bottom)
                $0.addArc(center: center,
                          radius: radius,
                          startAngle: .degrees(90),
                          endAngle: .degrees(-90),
                          clockwise: false)
                $0.addCurve(to: bottom,
                            control1: .init(x: center.x - horizontal, y: center.y + vertical),
                            control2: .init(x: center.x - horizontal, y: center.y - vertical))
            })
            
        case .firstQuarter, .lastQuarter:
            clip(to: .init {
                $0.addArc(center: center,
                          radius: radius,
                          startAngle: .degrees(90),
                          endAngle: .degrees(-90),
                          clockwise: false)
            })
            
        case .waxingCrescent, .waningCrescent:
            let bottom = CGPoint(x: center.x, y: center.y + radius)
            let delta = radius * (1 - (.init(fraction) / 50.0))
            let horizontal = delta * 1.25
            let vertical = delta / 1.25
            
            clip(to: .init {
                $0.move(to: bottom)
                $0.addArc(center: center,
                          radius: radius,
                          startAngle: .degrees(90),
                          endAngle: .degrees(-90),
                          clockwise: false)
                $0.addCurve(to: bottom,
                            control1: .init(x: center.x - horizontal, y: center.y - vertical),
                            control2: .init(x: center.x - horizontal, y: center.y + vertical))
            })
            
        default:
            clip(to: .init {
                $0.addArc(center: center,
                          radius: radius,
                          startAngle: .degrees(0),
                          endAngle: .degrees(360),
                          clockwise: false)
            })
        }
        
        draw(image, at: center)
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
