import SwiftUI
import Selene

extension Track {
    struct Content: View {
        @StateObject var status: Status
        let traits: [Trait]
        
        var body: some View {
            ScrollView {
                Text(status.day.id.relativeDays)
                    .fontWeight(Calendar.current.isDateInToday(status.day.id) ? .medium : .light)
                    .padding(.bottom)
                
                ForEach($status.items) { item in
                    HStack {
                        Slider(value: item.value) {
                            Text(item.id.title)
                        } onEditingChanged: {
                            if !$0 {
                                
                            }
                        }
                        .padding(.horizontal)
                        
                        VStack {
                            Image(systemName: "ladybug")
                            Text(item.id.title)
                                .font(.footnote)
                        }
                    }
                    .padding()
                }
            }
            .onChange(of: traits) {
                status.traits.send($0)
            }
            .onAppear {
                status.traits.send(traits)
            }
        }
    }
}
