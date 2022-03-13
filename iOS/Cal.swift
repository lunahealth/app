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
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        VStack(spacing: 0) {
            Header(index: $index, calendar: calendar)
            
            border
            
            ZStack {
                scheme == .dark ? Color.black : .accentColor.opacity(0.3)
                Ring(day: $day,
                     observatory: observatory,
                     month: month)
            }
            .fixedSize(horizontal: false, vertical: true)
            
            border
            
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
                Content(day: $day, active: active, traits: traits)
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
    
    private var border: some View {
        Rectangle()
            .fill(scheme == .dark ? Color(white: 1, opacity: 0.3) : .accentColor.opacity(0.5))
            .frame(height: 1)
    }
    
    private func update(index: Int) {
        month = calendar[index].items.flatMap { $0 }
        active = month.filter { $0.content.date <= .now }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
