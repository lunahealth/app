import Foundation
import CoreGraphics

extension Stars {
    final class Model: ObservableObject {
        private(set) var items = [Item]()
        private(set) var x = CGFloat()
        private var first = true
        
        func tick(date: Date, size: CGSize) {
            if first {
                first = false
                items = (0 ..< .random(in: 150 ..< 500)).map { _ in .new(size: size) }
            } else {
                x -= 0.07
                items = items
                    .map(\.tick)
                if abs(x) > size.width {
                    x = 0
                }
            }
        }
    }
}
