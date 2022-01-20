import SwiftUI
import Selene

struct TrackOld: View, Equatable {
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
        .sheet(isPresented: $preferences, onDismiss: {
            Task {
                await update()
            }
        }, content: Settings.Traits.init)
        .task {
            await update()
            
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
    
    private func update() async {
        let model = await cloud.model
        traits = model
            .settings
            .traits
            .filter {
                $0.active
            }
            .map {
                $0.id
            }
    }
    
    private func index(for date: Date) -> Int {
        week.firstIndex { Calendar.current.isDate($0.id, inSameDayAs: date) } ?? 0
    }
    
    static func == (lhs: TrackOld, rhs: TrackOld) -> Bool {
        true
    }
}
