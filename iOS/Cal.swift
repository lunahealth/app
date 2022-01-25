import SwiftUI
import Selene

struct Cal: View {
    weak var observatory: Observatory!
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("January 2022")
                }
                .padding(.top, 30)
                Spacer()
            }
            
            Canvas { context, size in
                let radius = min(size.width, size.height) * 0.48
                let center = CGPoint(x: size.width / 2, y: size.height / 2)
                
                context.fill(.init {
                    $0.addArc(center: center,
                              radius: radius,
                              startAngle: .degrees(0),
                              endAngle: .degrees(360),
                              clockwise: false)
                }, with: .color(.primary.opacity(0.1)))
                
                (0 ..< 9)
                    .forEach { index in
                        context.translateBy(x: center.x, y: center.y)
                        context.rotate(by: .degrees(360 / 31 * Double(index)))
                        context.translateBy(x: -center.x, y: -center.y)
                        
                        context.stroke(.init {
                            $0.move(to: center)
                            $0.addLine(to: .init(x: center.x, y: center.y + radius))
                        }, with: .color(.primary.opacity(0.3)))
                        
                        context.translateBy(x: center.x, y: center.y)
                        context.rotate(by: .degrees(360 / 31 * Double(-index)))
                        context.translateBy(x: -center.x, y: -center.y)
                    }
            }
        }
    }
}
