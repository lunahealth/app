import Foundation
import CoreGraphics

private let maxOpacity = 0.97
private let maxDelta = 0.05

extension Stars.Model {
    struct Item {
        let radius: Double
        let x: Double
        let y: Double
        let opacity: Double
        let blur: Double
        private let direction: Bool
        private let delta: Double
        private let step: Int
        
        static func new(size: CGSize) -> Self {
            .init(radius: .random(in: 0.6 ... 2),
                  x: .random(in: 0 ..< size.width * 2),
                  y: .random(in: 0 ..< size.height),
                  opacity: .random(in: 0 ... maxOpacity),
                  direction: .random(),
                  delta: .random(in: 0 ... maxDelta),
                  step: 0,
                  blur: 0)
        }
        
        var tick: Self {
            if step > 0 {
                if step <= 10 {
                    return .init(radius: radius,
                                 x: x,
                                 y: y,
                                 opacity: opacity,
                                 direction: direction,
                                 delta: delta,
                                 step: step + 1,
                                 blur: Double(step) / 10 * 0.75)
                } else {
                    return .init(radius: radius,
                                 x: x,
                                 y: y,
                                 opacity: opacity,
                                 direction: direction,
                                 delta: delta,
                                 step: step == 20 ? 0 : step + 1,
                                 blur: Double(20 - step) / 10 * 0.75)
                }
            }
            
            if Int.random(in: 0 ..< 50) == 0 {
                return .init(radius: radius,
                             x: x,
                             y: y,
                             opacity: opacity,
                             direction: direction,
                             delta: delta,
                             step: 1,
                             blur: 0)
            }
            
            if Int.random(in: 0 ..< 100) == 0 {
                return .init(radius: radius,
                             x: x,
                             y: y,
                             opacity: opacity,
                             direction: .random(),
                             delta: .random(in: 0 ... maxDelta),
                             step: 0,
                             blur: 0)
            }
            
            return .init(radius: radius,
                         x: x,
                         y: y,
                         opacity: apply,
                         direction: direction,
                         delta: delta,
                         step: 0,
                         blur: 0)
        }
        
        private init(radius: Double,
                     x: Double,
                     y: Double,
                     opacity: Double,
                     direction: Bool,
                     delta: Double,
                     step: Int,
                     blur: Double) {
            self.radius = radius
            self.x = x
            self.y = y
            self.opacity = opacity
            self.direction = direction
            self.delta = delta
            self.step = step
            self.blur = blur
        }
        
        private var apply: Double {
            max(min(direction ? opacity + delta : opacity - delta, maxOpacity), 0)
        }
    }
}
