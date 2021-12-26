import SwiftUI
import Selene

extension GraphicsContext {
    mutating func draw(moon: Moon, image: Image, shadow: Image, radius: Double, center: CGPoint) {
        translateBy(x: center.x, y: center.y)
        rotate(by: .radians(.pi_2 - moon.angle))
        translateBy(x: -center.x, y: -center.y)
        
        draw(shadow, at: center)
        
        switch moon.phase {
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
            let delta = radius * (1 - (.init(moon.fraction) / 50.0))
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
            let delta = radius * (1 - (.init(moon.fraction) / 50.0))
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
