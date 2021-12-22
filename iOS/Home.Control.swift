import SwiftUI
import Selene

private let radius = 28.0
private let radius2 = radius + radius

extension Home {
    struct Control: View {
        @Binding var date: Date
        let wheel: Selene.Wheel
        
        var body: some View {
            GeometryReader { proxy in
                Circle()
                    .stroke(Color(.tertiaryLabel), style: .init(lineWidth: 20))
                    .shadow(color: .init("Shadow"), radius: 10)
                    .opacity(0.2)
                    .padding(.horizontal, 50)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(coordinateSpace: .global)
                            .onChanged { gesture in
                                
                                let point = CGPoint(x: gesture.location.x - proxy.size.width / 2, y: (proxy.size.height - 120) - gesture.location.y)
                                //                            guard point.valid else { return nil }
                                print(point.radians)
                                
                                //                        withAnimation(.easeInOut(duration: 0.2)) {
                                //                            positions.drop = positions.cells
                                //                                .filter { session.match?[$0.0]?.player == nil }
                                //                                .first { $0.1.contains(gesture.location) }?.0
                                //                        }
                                //                        offset[bead] = gesture.translation
                            }
                        //                    .onEnded { _ in
                        //                        if let drop = positions.drop {
                        //                            withAnimation(.easeInOut(duration: 1)) {
                        //                                session.match![drop] = bead.item
                        //                                UIApplication.shared.next(session.match!)
                        //                            }
                        //                        } else {
                        //                            withAnimation(.easeInOut(duration: 0.5)) {
                        //                                offset[bead] = nil
                        //                            }
                        //                        }
                        //                        positions.drop = nil
                        //                    }
                    )
            }
        }
    }
}

extension CGPoint {
    var valid: Bool {
        let distance = pow(x, 2) + pow(y, 2)
        return distance > 100 && distance < 20_000
    }
    
    var radians: CGFloat {
        atan2(x, y)
    }
}
