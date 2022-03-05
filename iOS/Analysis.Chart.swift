import SwiftUI
import Selene

private let frames = 35.0

extension Analysis {
    struct Chart: View {
        let trait: Trait
        let value: [Moon.Phase : Level]
        private let dates = (0 ... .init(frames)).reduce(into: ([Date](), Date.now.timeIntervalSince1970)) {
            $0.0.append(Date(timeIntervalSince1970: $0.1 + 0.15 + (.init($1) / 50)))
        }.0
        
        var body: some View {
            TimelineView(.explicit(dates)) { timeline in
                Canvas { context, size in
                    
                    let vertical = (size.height - 35) / .init(Level.allCases.count)
                    let horizontal = (size.width - 80) / .init(Moon.Phase.allCases.count - 1)
                    var levels = [Level : CGFloat]()
                    var y = size.height - vertical
                    
                    Level
                        .allCases
                        .forEach { level in
                            context.draw(Text(Image(systemName: level.symbol))
                                            .font(.system(size: 13).weight(.medium))
                                            .foregroundColor(.primary), at: .init(x: 26, y: y))
                            levels[level] = y
                            y -= vertical
                        }
                    
                    var x = CGFloat(55)
                    
                    context.stroke(.init { path in
                        Moon
                            .Phase
                            .allCases
                            .forEach { phase in
                                let y = value[phase]
                                    .flatMap {
                                        levels[$0]
                                    } ?? 20
                                let point = CGPoint(x: x, y: y)
                                
                                if phase == .new {
                                    path.move(to: point)
                                } else {
                                    path.addLine(to: point)
                                }
                                
                                x += horizontal
                            }
                    }, with: .color(.primary), style: .init(lineWidth: 1, lineCap: .round, lineJoin: .round))
                    
                    /*
                    let width = (size.width - 20) / .init(phases.filter { value[$0] != nil }.count)
                    let height = (size.height - bottom) / .init(Level.allCases.count)
                    let spacing = size.height - bottom
                    let index = CGFloat(dates.firstIndex(of: timeline.date)!) + 1
                    let percent = index / frames
                    let sparkHorizontal = 60 * (1 - percent)
                    let sparkVertical = 10 * (1 - percent)
                    var x = (width / 2) + 10
                    
                    phases.forEach { phase in
                        if let level = value[phase] {
                            let bottom = CGPoint(x: x, y: size.height - 22)
                            let expected = spacing - (.init(Level.allCases.firstIndex(of: level)!) * height)
                            let distance = bottom.y - expected
                            let delta = min(percent * size.height, distance)
                            let top = CGPoint(x: x, y: bottom.y - delta)

                            context
                                .drawLayer { layer in
                                    layer.addFilter(.blur(radius: 6))
                                    
                                    layer
                                        .stroke(.init {
                                            $0.move(to: bottom)
                                            $0.addLine(to: top)
                                        }, with: .linearGradient(.init(colors: [.accentColor.opacity(1), .clear]),
                                                                 startPoint: bottom,
                                                                 endPoint: top),
                                                style: .init(lineWidth: 8, lineCap: .round))

                                    layer
                                        .fill(.init {
                                            $0.move(to: .init(x: top.x - sparkHorizontal, y: top.y))
                                            $0.addLine(to: .init(x: top.x, y: top.y - sparkVertical))
                                            $0.addLine(to: .init(x: top.x + sparkHorizontal, y: top.y))
                                            $0.addLine(to: .init(x: top.x, y: top.y + sparkVertical))
                                        }, with: .radialGradient(.init(stops: [.init(color: .accentColor, location: 0),
                                                                               .init(color: .clear, location: 1)]),
                                                                 center: top,
                                                                 startRadius: 0,
                                                                 endRadius: 60,
                                                                 options: .linearColor))
                                    
                                    layer
                                        .fill(.init {
                                            $0.addArc(center: top,
                                                      radius: 16,
                                                      startAngle: .radians(0),
                                                      endAngle: .radians(.pi2),
                                                      clockwise: false)
                                        }, with: .radialGradient(.init(stops: [.init(color: .accentColor.opacity(percent), location: 0),
                                                                               .init(color: .clear, location: 1)]),
                                                                 center: top,
                                                                 startRadius: 0,
                                                                 endRadius: 20,
                                                                 options: .linearColor))
                                    
                                    layer
                                        .fill(.init {
                                            $0.addArc(center: top,
                                                      radius: 14,
                                                      startAngle: .radians(0),
                                                      endAngle: .radians(.pi2),
                                                      clockwise: false)
                                        }, with: .radialGradient(.init(stops: [.init(color: .black.opacity(percent), location: 0),
                                                                               .init(color: .clear, location: 1)]),
                                                                 center: top,
                                                                 startRadius: 0,
                                                                 endRadius: 18,
                                                                 options: .linearColor))
                                }
                            
                            context
                                .fill(.init {
                                    $0.addArc(center: bottom,
                                              radius: 9,
                                              startAngle: .radians(0),
                                              endAngle: .radians(.pi2),
                                              clockwise: false)
                                }, with: .color(.accentColor))
                            
                            context
                                .drawLayer { layer in
                                    layer.draw(phase: phase,
                                               image: moonImage,
                                               shadow: shadowImage,
                                               radius: 8,
                                               center: bottom)
                                }
                            
                            context
                                .fill(.init {
                                    $0.addArc(center: top,
                                              radius: 14,
                                              startAngle: .radians(0),
                                              endAngle: .radians(.pi2),
                                              clockwise: false)
                                }, with: .color(.accentColor))
                            
                            context.draw(Text(Image(systemName: level.symbol))
                                            .font(.system(size: 13).weight(.medium))
                                            .foregroundColor(.white), at: top)
                            
                            x += width
                        }
                    }*/
                }
            }
            .frame(height: 210)
        }
    }
}
