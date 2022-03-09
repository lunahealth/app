import SwiftUI
import Dater
import Selene

struct Cal: View, Equatable {
    let observatory: Observatory
    @State private var index = 0
    @State private var day = 0
    @State private var calendar = [Days<Journal>]()
    @State private var month = [Days<Journal>.Item]()
    @State private var active = [Days<Journal>.Item]()
    @State private var traits = [Trait]()
    
    var body: some View {
        VStack(spacing: 0) {
            Header(index: $index, calendar: calendar)
            
            ZStack {
                Color(.secondarySystemBackground)
                Ring(day: $day,
                     observatory: observatory,
                     month: month)
            }
            .fixedSize(horizontal: false, vertical: true)
            .zIndex(-1)
            
            Strip(day: $day, observatory: observatory, month: active)
            
            TabView(selection: $day) {
                ForEach(active, id: \.value) { day in
                    Item(day: day, traits: traits)
                        .tag(day.value)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.bottom)
            .background(Color(.tertiarySystemBackground)
                            .edgesIgnoringSafeArea(.bottom)
                            .modifier(Shadowed()))
        }
        .animation(.easeInOut(duration: 0.5), value: index)
        .onChange(of: index) { value in
            if day > 1 {
                day = 1
            }
            update(index: value)
        }
        .onReceive(cloud) {
            traits = $0.settings.traits.sorted()
            calendar = $0.calendar
            index = calendar.count - 1
            update(index: index)
            day = month
                .filter {
                    $0.content.date <= .now
                }
                .count
        }
    }
    
    private func update(index: Int) {
        month = calendar[index].items.flatMap { $0 }
        active = month.filter { $0.content.date <= .now }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
