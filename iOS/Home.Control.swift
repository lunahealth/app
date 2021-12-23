import SwiftUI
import Selene

private let radius = 60.0

extension Home {
    struct Control: View {
        @Binding var date: Date
        let wheel: Wheel
        
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
                            .onChanged { value in
                                if let move = wheel.move(point: value.location, size: proxy.size, padding: 50) {
                                    date = move
                                }
                            }
                    )
            }
        }
    }
}
