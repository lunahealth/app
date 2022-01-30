import SwiftUI
import Selene

extension Analysis.Item {
    struct Display: View {
        let value: [Moon.Phase : Level]
        private let moonImage = Image("MoonMini")
        private let shadowImage = Image("ShadowMini")
        
        var body: some View {
            Canvas { context, size in
                let width = size.width / .init(Moon.Phase.allCases.count)
                var x = width / 2
                
                Moon.Phase.allCases.forEach { phase in
                    let bottom = CGPoint(x: x, y: size.height - 20)
                    let top = CGPoint(x: x, y: 50)
                    
                    context
                        .drawLayer { layer in
                            layer.addFilter(.blur(radius: 6))
                            
                            layer
                                .stroke(.init {
                                    $0.move(to: bottom)
                                    $0.addLine(to: top)
                                }, with: .linearGradient(.init(colors: [.accentColor, .clear]),
                                                         startPoint: bottom,
                                                         endPoint: top),
                                        style: .init(lineWidth: 8, lineCap: .round))

                            layer
                                .fill(.init {
                                    $0.addEllipse(in: .init(x: bottom.x - 30, y: bottom.y - 6, width: 60, height: 12))
                                }, with: .radialGradient(.init(stops: [.init(color: .accentColor, location: 0),
                                                                       .init(color: .clear, location: 1)]),
                                                         center: bottom,
                                                         startRadius: 0,
                                                         endRadius: 30,
                                                         options: .linearColor))
                            
                            layer
                                .fill(.init {
                                    $0.addArc(center: bottom,
                                              radius: 10,
                                              startAngle: .radians(0),
                                              endAngle: .radians(.pi2),
                                              clockwise: false)
                                }, with: .radialGradient(.init(stops: [.init(color: .accentColor, location: 0),
                                                                       .init(color: .clear, location: 1)]),
                                                         center: bottom,
                                                         startRadius: 0,
                                                         endRadius: 10,
                                                         options: .linearColor))
                        }
                    
                    context
                        .drawLayer { layer in
                            layer.draw(phase: phase,
                                       image: moonImage,
                                       shadow: shadowImage,
                                       radius: 7,
                                       center: bottom)
                        }
                    
                    x += width
                }
            }
        }
    }
}
