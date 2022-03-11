import SwiftUI
import Dater
import Selene

extension Cal {
    struct Strip: View {
        @Binding var day: Int
        let observatory: Observatory
        let month: [Days<Journal>.Item]
        private let haptics = UIImpactFeedbackGenerator(style: .soft)

        var body: some View {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        Spacer()
                            .frame(width: 30)
                        
                        ForEach(month, id: \.value) {
                            Item(day: $day, today: $0, moon: observatory.moon(for: $0.content.date))
                                .tag($0.value)
                                .id($0.value)
                        }
                        
                        Spacer()
                            .frame(width: 30)
                    }
                    .frame(height: 70)
                }
                .onChange(of: day) { selected in
                    haptics.impactOccurred()
                    
                    withAnimation(.easeInOut(duration: 0.35)) {
                        proxy.scrollTo(selected, anchor: .bottom)
                    }
                }
                .onAppear {
                    proxy.scrollTo(day, anchor: .bottom)
                    haptics.prepare()
                }
            }
            .background(Color(.tertiarySystemBackground)
                            .modifier(Shadowed()))
        }
    }
}
