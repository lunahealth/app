import SwiftUI
import Selene

struct Cal: View {
    weak var observatory: Observatory!
    private let moonImage = Image("MoonMini")
    private let shadowImage = Image("ShadowMini")
    
    let dates = Array(repeating: Date(), count: 31)
    
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
                
                context.stroke(.init {
                    $0.addArc(center: center,
                              radius: radius - 37,
                              startAngle: .degrees(0),
                              endAngle: .degrees(360),
                              clockwise: false)
                }, with: .color(.accentColor.opacity(0.15)), style: .init(lineWidth: 65))
                
                context.stroke(.init {
                    $0.addArc(center: center,
                              radius: radius - 52,
                              startAngle: .degrees(0),
                              endAngle: .degrees(360),
                              clockwise: false)
                }, with: .color(.init("Path").opacity(0.1)), style: .init(lineWidth: 40))

                context.stroke(.init {
                    $0.addArc(center: center,
                              radius: radius - 65,
                              startAngle: .degrees(0),
                              endAngle: .degrees(360),
                              clockwise: false)
                }, with: .color(.accentColor.opacity(0.1)), style: .init(lineWidth: 5))
                
                let rad = Double.pi2 / .init(dates.count)
                let half = rad / 2
                
                dates
                    .enumerated()
                    .forEach { date in
                        
                        let rotation = rad * .init(date.0)
                        
                        context.translateBy(x: center.x, y: center.y)
                        context.rotate(by: .radians(rotation))
                        context.translateBy(x: -center.x, y: -center.y)
                        
                        context.stroke(.init {
                            $0.move(to: center)
                            $0.addLine(to: .init(x: center.x, y: center.y - 105))
                        }, with: .color(.primary.opacity(0.1)), style: .init(lineWidth: 1, dash: [1, 3, 3, 5]))
                        
                        context.stroke(.init {
                            $0.move(to: .init(x: center.x, y: center.y - 105))
                            $0.addLine(to: .init(x: center.x, y: center.y - radius))
                        }, with: .color(.primary.opacity(0.4)), style: .init(lineWidth: 1, dash: [1, 3, 3, 5]))
                        
                        context.translateBy(x: center.x, y: center.y)
                        context.rotate(by: .radians(half))
                        context.translateBy(x: -center.x, y: -center.y)
                        
                        context.drawLayer { con in
                            con.draw(moon: observatory.moon(for: .now),
                                         image: moonImage,
                                         shadow: shadowImage,
                                         radius: 10,
                                     center: .init(x: center.x, y: center.y - radius + 18))
                        }
                        
                        context.draw(Text((date.0 + 1).formatted())
                                        .font(.system(size: 12)), at: .init(x: center.x, y: center.y - radius + 46))
                        
                        context.translateBy(x: center.x, y: center.y)
                        context.rotate(by: .radians(-(rotation + half)))
                        context.translateBy(x: -center.x, y: -center.y)
                    }
            }
        }
    }
}
