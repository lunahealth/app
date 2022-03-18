import SwiftUI
import Dater
import Selene

extension Cal.Content {
    struct Item: View {
        let day: Days<Journal>.Item
        let traits: [Trait]
        @Environment(\.colorScheme) private var scheme
        
        var body: some View {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text(day.content.date, format: .dateTime.weekday(.wide).day())
                        .font(.callout)
                        .padding(.top, 25)
                    
                    if day.today {
                        Text("Today")
                            .foregroundStyle(.secondary)
                            .font(.callout)
                            .padding(.top, 2)
                    }
                    
                    Spacer()
                }
                .frame(height: 70)
                
                Spacer()
                
                HStack(spacing: 15) {
                    ForEach(traits, id: \.self) { trait in
                        Element(day: day, trait: trait)
                    }
                }
                .frame(height: 90)
                
                Spacer()
            }
        }
    }
}
