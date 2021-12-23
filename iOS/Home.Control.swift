import SwiftUI
import Selene

extension Home {
    struct Control: View {
        @Binding var date: Date
        @Binding var wheel: Wheel?
        let moon: Moon
        
        var body: some View {
            GeometryReader { proxy in
                Circle()
                    .stroke(Color(.tertiaryLabel), style: .init(lineWidth: 20))
                    .shadow(color: .init("Shadow"), radius: 10)
                    .opacity(0.2)
                    .padding(.horizontal, 50)
                    .contentShape(Rectangle())
                    .onChange(of: proxy.size, perform: update(size:))
                    .onChange(of: moon) { _ in
                        update(size: proxy.size)
                    }
                    .onAppear {
                        update(size: proxy.size)
                    }
                    .gesture(
                        DragGesture(coordinateSpace: .local)
                            .onChanged { value in
                                if let move = wheel?.move(point: value.location) {
                                    date = move
                                }
                            }
                    )
            }
        }
        
        private func update(size: CGSize) {
            wheel = .init(date: date, moon: moon, correction: .pi_2, size: size, padding: 50)
        }
    }
}
