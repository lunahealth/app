import SwiftUI
import Dater
import Selene

extension Cal.Month {
    struct Header: View {
        @Binding var selection: Int
        let month: [Days<Journal>.Item]
        
        var body: some View {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Spacer()
                            .frame(width: 50)
                        
                        ForEach(month, id: \.value) { day in
                            Text(day.value.formatted())
                                .tag(day.value - 1)
                        }
                        
                        Spacer()
                            .frame(width: 50)
                    }
                }
                .onChange(of: selection) { selected in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        proxy.scrollTo(selected, anchor: .center)
                    }
                }
                .onAppear {
                    proxy.scrollTo(selection, anchor: .center)
                }
            }
            .frame(height: 100)
        }
    }
}
