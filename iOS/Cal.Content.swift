import SwiftUI
import Selene
import Dater

extension Cal {
    struct Content: View {
        @Binding var day: Int
        let active: [Days<Journal>.Item]
        let traits: [Trait]
        
        var body: some View {
            TabView(selection: $day) {
                ForEach(active, id: \.value) { day in
                    Item(day: day, traits: traits)
                        .tag(day.value)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut(duration: 0.4), value: day)
            .zIndex(1)
        }
    }
}
