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
    @State private var preferences = false
    
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
            
            Rectangle()
                .fill(Color.primary.opacity(0.1))
                .frame(height: 1)
            
            if traits.isEmpty {
                Spacer()
                
                Button {
                    preferences = true
                } label: {
                    Text("Adjust preferences")
                        .font(.footnote)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                
                Spacer()
            } else {
                TabView(selection: $day) {
                    ForEach(active, id: \.value) { day in
                        Item(day: day, traits: traits)
                            .tag(day.value)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .background(Color(.tertiarySystemBackground))
                .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: index)
        .sheet(isPresented: $preferences, content: Settings.Traits.init)
        .onChange(of: index) { value in
            if day > 1 {
                day = 1
            }
            update(index: value)
        }
        .onReceive(cloud) {
            traits = $0.settings.traits.sorted()
            calendar = $0.calendar
            
            if day == 0 {
                index = calendar.count - 1
                update(index: index)
                
                day = month
                    .filter {
                        $0.content.date <= .now
                    }
                    .count
            }
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
