import SwiftUI
import Selene

extension Home {
    struct Main: View {
        @Binding var date: Date
        @Binding var wheel: Wheel?
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
                    VStack {
                        Image(systemName: "plus.circle")
                            .font(.title.weight(.light))
                        Text("Track")
                            .font(.footnote)
                    }
                    .foregroundColor(.primary)
                    .contentShape(Rectangle())
                }
                .disabled(!date.trackable)
                .opacity(date.trackable ? 1 : 0.3)
                .sheet(isPresented: $track, content: Track.init)
            }
            .frame(maxWidth: 450, maxHeight: 450)
        }
    }
}
