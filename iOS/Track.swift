import SwiftUI
import Selene

struct Track: View, Equatable {
    @Binding var date: Date
    let week: [Day]
    @State private var traits = [Trait]()
    @State private var selection = 0
    @State private var preferences = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Header(date: $date, week: week)
                TabView(selection: $selection) {
                    ForEach(week) { day in
                        Content(status: .init(day: day), traits: traits)
                            .tag(index(for: day.id))
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .navigationTitle(date.relativeDays)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Track")
                }
            }
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $preferences, content: Settings.Traits.init)
        .onReceive(cloud.first()) {
            traits = $0
                .settings
                .traits
                .filter {
                    $0.active
                }
                .map {
                    $0.id
                }
            
            if traits.isEmpty {
                preferences = true
            }
        }
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
    
    static func == (lhs: Track, rhs: Track) -> Bool {
        true
    }
}
