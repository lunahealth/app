import SwiftUI
import Selene

private let bottom = 70.0
private let frames = 130.0

extension Analysis {
    struct Item: View, Equatable {
        let value: [Moon.Phase : Level]
        let phases: [Moon.Phase]
        private let moonImage = Image("MoonMini")
        private let shadowImage = Image("ShadowMini")
        private let dates = (40 ..< .init(frames + 50)).map { Calendar.current.date(byAdding: .nanosecond, value: $0 * 500_000_0, to: .now)! }
        
        var body: some View {
            TimelineView(.explicit(dates)) { timeline in
                Canvas { context, size in
                    let width = (size.width - 20) / .init(phases.filter { value[$0] != nil }.count)
                    let height = (size.height - bottom) / .init(Level.allCases.count)
                    let spacing = size.height - bottom
                    let percent = min(CGFloat(dates.firstIndex(of: timeline.date)!), frames) / frames
                    var x = (width / 2) + 10
                    
                    phases.forEach { phase in
                        if let level = value[phase] {
                            let bottom = CGPoint(x: x, y: size.height - 22)
                            let expected = spacing - (.init(Level.allCases.firstIndex(of: level)!) * height)
                            let delta = (bottom.y - expected) * percent
                            let top = CGPoint(x: x, y: bottom.y - delta)

                            context
                                .drawLayer { layer in
                                    layer.addFilter(.blur(radius: 6))
                                    
                                    layer
                                        .stroke(.init {
                                            $0.move(to: bottom)
                                            $0.addLine(to: top)
                                        }, with: .linearGradient(.init(colors: [.accentColor, .clear]),
                                                                 startPoint: top,
                                                                 endPoint: bottom),
                                                style: .init(lineWidth: 8, lineCap: .round))

                                    layer
                                        .fill(.init {
                                            $0.move(to: .init(x: top.x - 35, y: top.y))
                                            $0.addLine(to: .init(x: top.x, y: top.y - 8))
                                            $0.addLine(to: .init(x: top.x + 35, y: top.y))
                                            $0.addLine(to: .init(x: top.x, y: top.y + 8))
                                        }, with: .radialGradient(.init(stops: [.init(color: .accentColor.opacity(percent), location: 0),
                                                                               .init(color: .clear, location: 1)]),
                                                                 center: top,
                                                                 startRadius: 0,
                                                                 endRadius: 40,
                                                                 options: .linearColor))
                                    
                                    layer
                                        .fill(.init {
                                            $0.addArc(center: top,
                                                      radius: 20,
                                                      startAngle: .radians(0),
                                                      endAngle: .radians(.pi2),
                                                      clockwise: false)
                                        }, with: .radialGradient(.init(stops: [.init(color: .accentColor, location: 0),
                                                                               .init(color: .clear, location: 1)]),
                                                                 center: top,
                                                                 startRadius: 0,
                                                                 endRadius: 20,
                                                                 options: .linearColor))
                                    
                                    layer
                                        .fill(.init {
                                            $0.addArc(center: top,
                                                      radius: 18,
                                                      startAngle: .radians(0),
                                                      endAngle: .radians(.pi2),
                                                      clockwise: false)
                                        }, with: .radialGradient(.init(stops: [.init(color: .black, location: 0),
                                                                               .init(color: .clear, location: 1)]),
                                                                 center: top,
                                                                 startRadius: 0,
                                                                 endRadius: 18,
                                                                 options: .linearColor))
                                }
                            
                            context
                                .fill(.init {
                                    $0.addArc(center: top,
                                              radius: 12,
                                              startAngle: .radians(0),
                                              endAngle: .radians(.pi2),
                                              clockwise: false)
                                }, with: .color(.accentColor))
                            
                            context.draw(Text(Image(systemName: level.symbol))
                                            .font(.system(size: 13).weight(.medium))
                                            .foregroundColor(.white), at: top)
                            
                            context
                                .fill(.init {
                                    $0.addArc(center: bottom,
                                              radius: 12,
                                              startAngle: .radians(0),
                                              endAngle: .radians(.pi2),
                                              clockwise: false)
                                }, with: .color(.accentColor))
                            
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
            .frame(height: 260)
            .padding(.vertical)
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.value == rhs.value && lhs.phases == rhs.phases
        }
    }
}
