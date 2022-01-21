import Foundation
import CoreGraphics

extension Stars.Model {
    struct Item {
        let radius: Double
        let x: Double
        let y: Double
        let opacity: Double
        private let decrease: Double
        
        static func new(size: CGSize) -> Self {
            .init(radius: .random(in: 0.1 ... 5),
                  x: .random(in: 0 ..< size.width),
                  y: .random(in: 0 ..< size.height),
                  opacity: .random(in: 0.01 ..< 0.95),
                  decrease: .random(in: 1.0002 ..< 1.035))
        }
        
        private init(radius: Double, x: Double, y: Double, opacity: Double, decrease: Double) {
            self.radius = radius
            self.x = x
            self.y = y
            self.opacity = opacity
            self.decrease = decrease
        }
        
        func tick() -> Self? {
            radius > 0.01 ? .init(radius: radius / decrease, x: x, y: y, opacity: opacity, decrease: decrease) : nil
        }
    }
}
