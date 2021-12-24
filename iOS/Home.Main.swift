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
            }
            .frame(maxWidth: 450, maxHeight: 450)
        }
    }
}
