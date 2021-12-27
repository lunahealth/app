import SwiftUI
import Selene

struct Track: View {
    @Binding var date: Date
    let week: [Day]
    @State private var selection = 0
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Header(date: $date, week: week)
                    .equatable()
                TabView(selection: $selection) {
                    ForEach(week) { day in
                        Content(day: day)
                            .tag(index(for: day.id))
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .navigationTitle("Track")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .onChange(of: selection) {
            date = week[$0].id
        }
        .onChange(of: date) {
            selection = index(for: $0)
        }
        .onAppear {
            selection = index(for: date)
        }
    }
    
    private func index(for date: Date) -> Int {
        week.firstIndex { Calendar.current.isDate($0.id, inSameDayAs: date) } ?? 0
    }
}
