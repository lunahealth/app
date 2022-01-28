import Foundation
import CoreGraphics

extension Stars {
    final class Model: ObservableObject {
        private(set) var items = [Item]()
        private var first = true
        
        deinit {
            print("deinit")
        }
        
        func tick(date: Date, size: CGSize) {
            if first {
                first = false
                items = (0 ..< .random(in: 20 ..< 200)).map { _ in .new(size: size) }
            } else {
                items = items
                    .map(\.tick)
            }
        }
    }
}
