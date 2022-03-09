import SwiftUI
import Dater
import Selene

extension Cal.Strip {
    struct Item: View {
        @Binding var day: Int
        let today: Days<Journal>.Item
        let moon: Moon
        
        var body: some View {
            Canvas { context, size in
                context.draw(moon: moon,
                             render: .small,
                             center: .init(x: 26, y: 23))
            }
            .opacity(day == today.value ? 1 : 0.5)
            .frame(width: 52, height: 60)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.4)) {
                    day = today.value
                }
            }
        }
    }
}
