import SwiftUI
import Selene

extension Settings {
    struct Traits: View {
        @Environment(\.dismiss) private var dismiss
        private let all = Trait.allCases.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
        
        var body: some View {
            NavigationView {
                List {
                    Section("Choose the traits you want to track.") {
                        ForEach(all, id: \.self) { trait in
                            Item(trait: trait)
                        }
                    }
                    .headerProminence(.increased)
                }
                .navigationTitle("Traits")
                .navigationBarTitleDisplayMode(.inline)
                .toggleStyle(SwitchToggleStyle(tint: .mint))
                .listStyle(.grouped)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                                .font(.callout.weight(.medium))
                                .foregroundColor(.blue)
                                .padding(.leading)
                                .frame(height: 34)
                                .contentShape(Rectangle())
                        }
                    }
                }
            }
            .navigationViewStyle(.stack)
        }
    }
}
