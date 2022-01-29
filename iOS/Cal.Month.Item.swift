import SwiftUI
import Dater
import Selene

extension Cal.Month {
    struct Item: View {
        let day: Days<Journal>.Item
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.regularMaterial)
                VStack {
                    Text(day.content.date, format: .dateTime)
                    Spacer()
                }
                .padding()
            }
            .padding()
        }
    }
}
