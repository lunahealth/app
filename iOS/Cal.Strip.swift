import SwiftUI
import Dater
import Selene

extension Cal {
    struct Strip: View {
        @Binding var day: Int
        let observatory: Observatory
        let month: [Days<Journal>.Item]
        private let haptics = UIImpactFeedbackGenerator(style: .soft)
        private let audio = Audio()

        var body: some View {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        Spacer()
                            .frame(width: 30)
                        
                        ForEach(month, id: \.value) {
                            Item(day: $day, item: $0, moon: observatory.moon(for: $0.content.date))
                                .tag($0.value)
                                .id($0.value)
                        }
                        
                        Spacer()
                            .frame(width: 30)
                    }
                    .frame(height: 64)
                }
                .edgesIgnoringSafeArea(.all)
                .background(Color(.tertiarySystemBackground)
                                .modifier(Shadowed(level: .minimum)))
                .onChange(of: day) { [previous = day] selected in
                    guard selected != previous, previous != 0 else {
                        proxy.scrollTo(selected, anchor: .bottom)
                        return
                    }
                    
                    if Defaults.enableHaptics {
                        haptics.impactOccurred()
                    }
                    
                    if Defaults.enableSounds {
                        audio.play()
                    }
                    
                    withAnimation(.easeInOut(duration: 0.35)) {
                        proxy.scrollTo(selected, anchor: .bottom)
                    }
                }
                .onAppear {
                    proxy.scrollTo(day, anchor: .bottom)
                    
                    if Defaults.enableHaptics {
                        haptics.prepare()
                    }
                }
            }
        }
    }
}
