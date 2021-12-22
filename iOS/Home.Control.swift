import SwiftUI
import Selene

private let radius = 60.0

extension Home {
    struct Control: View {
        @Binding var date: Date
        let wheel: Wheel
        @GestureState private var source: Double?
        
        var body: some View {
            GeometryReader { proxy in
                Circle()
                    .stroke(Color(.tertiaryLabel), style: .init(lineWidth: 20))
                    .shadow(color: .init("Shadow"), radius: 10)
                    .opacity(0.2)
                    .padding(.horizontal, 50)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(coordinateSpace: .local)
                            .updating($source) { value, state, _ in
                                
                                
                                guard let s = state else {
                                    let origin = wheel.point.origin(size: proxy.size, padding: 50)
                                    if abs(origin.x - value.location.x) < radius
                                        && abs(origin.y - value.location.y) < radius {
                                        state = wheel.radians
                                    }
                                    return
                                }
//                                 let rads = CGPoint(x: value.location.x - proxy.size.width / 2,
//                                                     y: (proxy.size.height / 2) - value.location.y)
//                                    .angleToPoint
                                let rads = CGPoint(x: proxy.size.width / 2, y: proxy.size.height / 2).angleToPoint(pointOnCircle: value.location)
                                
                                print("\(rads) - \(s)")
                                var delta = rads - s
                                if abs(delta) > .pi {
                                    delta += .pi2
                                    print(delta)
                                }
                                date = wheel.move(radians: delta)
                                state = nil
                            }
                    )
            }
        }
    }
}

extension CGPoint {
    var radians: CGFloat {
        atan2(x, y)
    }
    
    func angleToPoint(pointOnCircle: CGPoint) -> CGFloat {
            
            let originX =  pointOnCircle.x - self.x
            let originY = self.y - pointOnCircle.y
        var radians = atan2(originX, originY) - .pi_2
            
            if radians < 0 {
                radians += CGFloat(2 * Double.pi)
            }
            
            return radians
        }
}
