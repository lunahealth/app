import SwiftUI
import Selene

private let pad = 45.0

extension Home {
    struct Control: View {
        @Binding var date: Date
        @Binding var navigator: Navigator?
        let moon: Moon
        let track: Bool
        let maxWidth: CGFloat
        
        var body: some View {
            GeometryReader { proxy in
                HStack {
                    Spacer()
                    Circle()
                        .stroke(LinearGradient(gradient: .init(colors: [
                            .init(white: 1, opacity: 0.3),
                            .init(white: 1, opacity: 0)]), startPoint: .top, endPoint: .bottom), style: .init(lineWidth: 6))
                        .shadow(color: .accentColor, radius: 10)
                        .padding(pad - 7)
                        .contentShape(Rectangle())
                        .frame(maxWidth: maxWidth)
                        .opacity(track ? 0 : 1)
                        .animation(.easeInOut(duration: 0.3), value: track)
                    Spacer()
                }
                .onChange(of: proxy.size) {
                    update(moon: moon, size: $0, track: track)
                }
                .onChange(of: moon) {
                    update(moon: $0, size: proxy.size, track: track)
                }
                .onChange(of: track) {
                    update(moon: moon, size: proxy.size, track: $0)
                }
                .onAppear {
                    update(moon: moon, size: proxy.size, track: track)
                }
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { value in
                            if !track, let move = navigator?.move(point: value.location) {
                                date = move
                            }
                        }
                )
            }
            .frame(maxWidth: .greatestFiniteMagnitude)
        }
        
        private func update(moon: Moon, size: CGSize, track: Bool) {
            navigator = track
            ? Tracker(size: size)
            : Wheel(date: date,
                    moon: moon,
                    correction: .pi_2,
                    size: size,
                    padding: pad,
                    maxWidth: maxWidth)
        }
    }
}
