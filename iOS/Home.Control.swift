import SwiftUI
import Selene

private let pad = 45.0

extension Home {
    struct Control: View {
        @Binding var date: Date
        @Binding var wheel: Wheel?
        let moon: Moon
        
        var body: some View {
            GeometryReader { proxy in
                Circle()
                    .stroke(LinearGradient(gradient: .init(colors: [
                        .init(white: 1, opacity: 0.4),
                        .init(white: 1, opacity: 0)]), startPoint: .top, endPoint: .bottom), style: .init(lineWidth: 9))
                    .shadow(color: .accentColor.opacity(0.5), radius: 10)
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
                        DragGesture(minimumDistance: 0, coordinateSpace: .local)
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
