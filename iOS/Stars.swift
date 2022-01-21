import SwiftUI

private let pi2 = Double.pi * 2

struct Stars: View, Equatable {
    @StateObject private var model = Stars.Model()
    
    var body: some View {
        TimelineView(.periodic(from: .now, by: 0.05)) { timeline in
            Canvas { context, size in
                model.tick(date: timeline.date, size: size)

                model
                    .items
                    .forEach { particle in
                        context
                            .fill(.init {
                                $0.addArc(center: .init(x: particle.x, y: particle.y),
                                          radius: particle.radius,
                                          startAngle: .degrees(0),
                                          endAngle: .degrees(360),
                                          clockwise: false)
                            }, with: .color(.white))
                    }
            }
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
