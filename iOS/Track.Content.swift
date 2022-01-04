import SwiftUI
import Selene

extension Track {
    struct Content: View {
        let traits: [Trait]
        let day: Day
        @State private var a = 0.0
        
        var body: some View {
            ScrollView {
                Text(day.id.relativeDays)
                    .fontWeight(Calendar.current.isDateInToday(day.id) ? .medium : .light)
                    .padding(.bottom)
                
                ForEach(traits, id: \.self) { trait in
                    HStack {
                        Slider(value: $a) {
                            Text(trait.title)
                        } onEditingChanged: {
                            if !$0 {
                                
                            }
                        }
                        .padding(.horizontal)
                        
                        VStack {
                            Image(systemName: "ladybug")
                            Text(trait.title)
                                .font(.footnote)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
