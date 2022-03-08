import SwiftUI
import Dater
import Selene

extension Cal.Strip {
    struct Item: View {
        @Binding var selection: Int
        let day: Days<Journal>.Item
        let moon: Moon
        
        var body: some View {
            Canvas { context, size in
                if selection == day.value {
                    context.draw(moon: moon,
                                 render: .small,
                                 center: .init(x: 32, y: 23))
                } else {
                    context.draw(moon: moon,
                                 render: .mini,
                                 center: .init(x: 32, y: 23))
                }
            }
            .opacity(selection == day.value ? 1 : 0.5)
            .frame(width: 64, height: 60)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.4)) {
                    selection = day.value
                }
            }
        }
    }
}
