import SwiftUI
import Dater
import Selene

struct Cal: View {
    weak var observatory: Observatory!
    @State private var calendar = [Days<Journal>]()
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            if let month = calendar.last {
                Text(Calendar.current.date(from: .init(year: month.year, month: month.month))!,
                     format: .dateTime.year().month(.wide))
                    .font(.footnote)
                
                Ring(observatory: observatory, month: month.items.flatMap { $0 })
            }
        }
        .task {
            calendar = await cloud.model.calendar
        }
    }
}
