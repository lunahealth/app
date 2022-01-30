import SwiftUI
import Selene

private let bottom = 70.0

extension Analysis.Item {
    struct Display: View {
        let value: [Moon.Phase : Level]
        private let moonImage = Image("MoonMini")
        private let shadowImage = Image("ShadowMini")
        
        var body: some View {
            Canvas { context, size in
                let width = (size.width - 20) / .init(Moon.Phase.allCases.count)
                let height = (size.height - bottom) / .init(Level.allCases.count)
                let spacing = size.height - bottom
                var x = (width / 2) + 10
                
                Moon.Phase.allCases.forEach { phase in
                    if let level = value[phase] {
                        let bottom = CGPoint(x: x, y: size.height - 22)
                        let top = CGPoint(x: x, y: spacing - (.init(Level.allCases.firstIndex(of: level)!) * height))
                        
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
                        
                        context
                            .fill(.init {
                                $0.addArc(center: top,
                                          radius: 15,
                                          startAngle: .radians(0),
                                          endAngle: .radians(.pi2),
                                          clockwise: false)
                            }, with: .color(.accentColor))
                        
                        context.draw(Text(Image(systemName: level.symbol))
                                        .font(.system(size: 13).weight(.medium))
                                        .foregroundColor(.white), at: top)
                    }
                    
                    x += width
                }
            }
        }
    }
}
