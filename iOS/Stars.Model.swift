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
            items = items
                .compactMap {
                    $0.tick()
                }
            
            if first {
                first = false
                items = (0 ..< 50).map { _ in .new(size: size) }
            }
            
            if Int.random(in: 0 ..< 100) == 0 {
                items.append(.new(size: size))
            }
        }
    }
}
