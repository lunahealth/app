import SwiftUI
import Selene
import Dater

extension Cal {
    struct Content: View {
        @Binding var day: Int
        let active: [Days<Journal>.Item]
        let traits: [Trait]
        private let haptics = UIImpactFeedbackGenerator(style: .soft)
        
        var body: some View {
            TabView(selection: $day) {
                ForEach(active, id: \.value) { day in
                    Item(day: day, traits: traits)
                        .tag(Int(day.value))
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut(duration: 0.4), value: day)
            .background(Color(.tertiarySystemBackground))
            .onChange(of: day) { [previous = day] selected in
                guard selected != previous, previous != 0 else { return }
                
                if Defaults.enableHaptics {
                    haptics.impactOccurred()
                }
            }
            .onAppear {
                if Defaults.enableHaptics {
                    haptics.prepare()
                }
            }
        }
    }
}
