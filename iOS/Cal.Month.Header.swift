import SwiftUI
import Dater
import Selene

extension Cal.Month {
    struct Header: View {
        @Binding var selection: Int
        weak var observatory: Observatory!
        let month: [Days<Journal>.Item]

        var body: some View {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        Spacer()
                            .frame(width: 50)
                        
                        ForEach(month, id: \.value) {
                            Item(selection: $selection, day: $0, moon: observatory.moon(for: $0.content.date))
                                .tag($0.value)
                                .id($0.value)
                        }
                        
                        Spacer()
                            .frame(width: 50)
                    }
                    .frame(height: 160)
                }
                .onChange(of: selection) { selected in
                    withAnimation(.easeInOut(duration: 5)) {
                        proxy.scrollTo(selected, anchor: .bottom)
                    }
                }
                .onAppear {
                    proxy.scrollTo(selection, anchor: .bottom)
                }
            }
        }
    }
}
