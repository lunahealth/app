import SwiftUI
import Selene

extension Home {
    struct Main: View {
        @Binding var date: Date
        @Binding var wheel: Wheel?
        let status: Status
        let observatory: Observatory
        let moon: Moon
        @State private var track = false
        @State private var alert = false
        
        var body: some View {
            ZStack {
                Control(date: $date, wheel: $wheel, moon: moon)
                if let wheel = wheel {
                    Render(moon: moon, wheel: wheel, current: wheel.origin)
                        .allowsHitTesting(false)
                }
                Button {
                    if date.trackable {
                        track = true
                    } else {
                        alert = true
                    }
                } label: {
                    VStack {
                        Image(systemName: "plus.circle")
                            .font(.title)
                        Text("Track")
                            .font(.body.weight(.medium))
                    }
                    .opacity(date.trackable ? 1 : 0.3)
                    .foregroundColor(.primary)
                    .contentShape(Rectangle())
                }
                .alert(date > .now ? "You can't track in the future" : "You can't track more than a week ago", isPresented: $alert) {
                    Button("OK", role: .cancel) {
                        
                    }
                }
                .sheet(isPresented: $track) {
                    Track(date: $date, status: status, week: observatory.week)
                }
            }
            .frame(maxWidth: 450, maxHeight: 450)
        }
    }
}
