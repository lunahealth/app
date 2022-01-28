import SwiftUI
import Dater
import Selene

extension Cal.Month {
    struct Header: View {
        let month: [Days<Journal>.Item]
        
        var body: some View {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(month, id: \.value) { day in
                        Text(day.value.formatted())
                            .tag(day.value)
                    }
                }
            }
            .frame(height: 100)
        }
    }
}
