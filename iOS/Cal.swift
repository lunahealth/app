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
            
            VStack {
                HStack {
                    Text("January 2022")
                }
                .padding(.top, 30)
                Spacer()
            }
            
            Ring(observatory: observatory, calendar: calendar.flatMap { $0.items.flatMap { $0 } })
        }
        .task {
            calendar = await cloud.model.calendar
        }
    }
}
