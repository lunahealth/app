import SwiftUI
import Selene

private let radius = 28.0
private let radius2 = radius + radius

extension Home {
    struct Render: View {
        let moon: Moon
        let wheel: Wheel
        @State var current: CGPoint
        private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        private let image = Image("Moon")
        
        var body: some View {
            
            Canvas { context, size in
                context.fill(.init {
                    $0.addArc(center: current,
                              radius: radius,
                              startAngle: .degrees(0),
                              endAngle: .degrees(360),
                              clockwise: true)
                }, with: .color(.primary))
                
                /*
                 
                 context.translateBy(x: center.x, y: center.y)
                 context.rotate(by: .radians(.pi_2 - moon.angle))
                 context.translateBy(x: -center.x, y: -center.y)
                 
                 context.fill(.init {
                 $0.addArc(center: center,
                 radius: radius + 1,
                 startAngle: .degrees(0),
                 endAngle: .degrees(360),
                 clockwise: false)
                 }, with: .color(.init(.quaternarySystemFill)))
                 
                 switch moon.phase {
                 case .new:
                 context.clip(to: .init {
                 $0.addArc(center: center,
                 radius: radius,
                 startAngle: .degrees(0),
                 endAngle: .degrees(0),
                 clockwise: false)
                 })
                 
                 case .waxingGibbous, .waningGibbous:
                 let delta = radius2 * (1 - (.init(moon.fraction) / 100.0))
                 
                 context.clip(to: .init {
                 $0.addEllipse(in: .init(
                 x: center.x - radius - delta,
                 y: center.y - radius - delta,
                 width: radius2,
                 height: radius2 + delta * 2))
                 })
                 
                 case .firstQuarter, .lastQuarter:
                 context.clip(to: .init {
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
                 
                 context.clip(to: .init {
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
                 break
                 }
                 
                 context.draw(image, at: center)
                 */
            }
            .onReceive(timer) { _ in
                if wheel.origin != current {
                    current = wheel.approach(from: current)
                }
            }
        }
    }
}
