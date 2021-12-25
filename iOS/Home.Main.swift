import SwiftUI
import Selene

extension Home {
    struct Main: View {
        @Binding var date: Date
        @Binding var wheel: Wheel?
        let moon: Moon
        
        var body: some View {
            ZStack {
                Control(date: $date, wheel: $wheel, moon: moon)
                if let wheel = wheel {
                    Render(moon: moon, wheel: wheel, current: wheel.origin)
                        .allowsHitTesting(false)
                }
                Button {
                    
                } label: {
                    VStack {
                        Image(systemName: "plus.circle")
                            .font(.title.weight(.light))
                        Text("Track")
                            .font(.footnote)
                    }
                    .foregroundColor(.primary)
                }
                .disabled(!date.trackable)
                .opacity(date.trackable ? 1 : 0.3)
            }
            .frame(maxWidth: 450, maxHeight: 450)
        }
    }
}
