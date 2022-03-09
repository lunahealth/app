import SwiftUI
import Dater
import Selene

extension Cal {
    struct Strip: View {
        @Binding var day: Int
        let observatory: Observatory
        let month: [Days<Journal>.Item]

        var body: some View {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        Spacer()
                            .frame(width: 50)
                        
                        ForEach(month, id: \.value) {
                            Item(day: $day, today: $0, moon: observatory.moon(for: $0.content.date))
                                .tag($0.value)
                                .id($0.value)
                        }
                        
                        Spacer()
                            .frame(width: 50)
                    }
                    .frame(height: 70)
                }
                .onChange(of: day) { selected in
                    withAnimation(.easeInOut(duration: 0.35)) {
                        proxy.scrollTo(selected, anchor: .bottom)
                    }
                }
                .onAppear {
                    proxy.scrollTo(day, anchor: .bottom)
                }
            }
            .background(Color(.tertiarySystemBackground)
                            .modifier(Shadowed()))
        }
    }
}
