import SwiftUI

struct Stars: View, Equatable {
    @StateObject private var model = Stars.Model()
    
    var body: some View {
        TimelineView(.periodic(from: .now, by: 0.05)) { timeline in
            Canvas { context, size in
                model.tick(date: timeline.date, size: size)

                model
                    .items
                    .forEach { item in
                        context.fill(.init {
                            $0.addArc(center: .init(x: item.x + model.x, y: item.y),
                                      radius: item.radius + (item.radius * 4 * item.blur),
                                      startAngle: .radians(0),
                                      endAngle: .radians(.pi2),
                                      clockwise: false)
                        }, with: .radialGradient(.init(stops: [.init(color: .white.opacity(item.opacity), location: 0),
                                                               .init(color: .white.opacity(item.opacity), location: 1 - item.blur),
                                                               .init(color: .white.opacity(item.opacity / 2), location: 1 - item.blur),
                                                               .init(color: .clear, location: 1)]),
                                                 center: .init(x: item.x + model.x, y: item.y),
                                                 startRadius: 0,
                                                 endRadius: item.radius + (item.radius * 4 * item.blur),
                                                 options: .linearColor))
                    }
            }
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
