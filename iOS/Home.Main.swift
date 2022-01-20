import SwiftUI
import Selene

extension Home {
    struct Main: View {
        @Binding var date: Date
        @Binding var wheel: Wheel?
        weak var observatory: Observatory!
        let moon: Moon
        @State private var track = false
        
        var body: some View {
            ZStack {
                Control(date: $date, wheel: $wheel, moon: moon)
                if let wheel = wheel {
                    Render(moon: moon, wheel: wheel, current: wheel.origin)
                        .allowsHitTesting(false)
                }
                Button {
                    track = true
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.primary)
                        Text("Track")
                            .font(.body.weight(.medium))
                            .foregroundColor(.primary)
                            .colorInvert()
                            .padding(24)
                    }
                    .fixedSize()
                    .contentShape(Rectangle())
                }
                .sheet(isPresented: $track) {
                    Track(date: $date, week: observatory.week)
                        .equatable()
                }
            }
            .frame(maxWidth: 450, maxHeight: 450)
        }
    }
}
