import SwiftUI
import Dater
import Selene

struct Cal: View, Equatable {
    let observatory: Observatory
    @State private var index = 0
    @State private var selection = 0
    @State private var calendar = [Days<Journal>]()
    @State private var month = [Days<Journal>.Item]()
    @State private var traits = [Trait]()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Header(index: $index, selection: $selection, calendar: calendar)
                Strip(selection: $selection, observatory: observatory, month: month)
            }
            .background(Color(.tertiarySystemBackground)
                            .modifier(Shadowed()))
            ZStack {
                Color(.secondarySystemBackground)
                Ring(selection: $selection,
                     observatory: observatory,
                     month: month)
            }
            .fixedSize(horizontal: false, vertical: true)
            .zIndex(-1)
            TabView(selection: $selection) {
                ForEach(month, id: \.value) { day in
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
            if selection > 1 {
                selection = 1
            }
            update(index: value)
        }
        .onReceive(cloud) {
            traits = $0.settings.traits.sorted()
            calendar = $0.calendar
            index = calendar.count - 1
            update(index: index)
            selection = month
                .filter {
                    $0.content.date <= .now
                }
                .count
        }
    }
    
    private func update(index: Int) {
        month = calendar[index].items.flatMap { $0 }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
