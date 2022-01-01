import SwiftUI
import Selene

private let pad = 65.0

extension Home {
    struct Control: View {
        @Binding var date: Date
        @Binding var wheel: Wheel?
        let moon: Moon
        
        var body: some View {
            GeometryReader { proxy in
                Circle()
                    .stroke(Color("Path").opacity(0.5), style: .init(lineWidth: 28))
                    .shadow(color: .init("Purple").opacity(0.5), radius: 40)
                    .padding(pad)
                    .contentShape(Rectangle())
                    .onChange(of: proxy.size) {
                        update(moon: moon, size: $0)
                    }
                    .onChange(of: moon) {
                        update(moon: $0, size: proxy.size)
                    }
                    .onAppear {
                        update(moon: moon, size: proxy.size)
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
        
        private func update(moon: Moon, size: CGSize) {
            wheel = .init(date: date, moon: moon, correction: .pi_2, size: size, padding: pad)
        }
    }
}
