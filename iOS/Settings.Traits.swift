import SwiftUI
import Selene

extension Settings {
    struct Traits: View {
        @State private var first = false
        @Environment(\.dismiss) private var dismiss
        private let all = Trait.allCases.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
        
        var body: some View {
            NavigationView {
                List {
                    Section {
                        ForEach(all, id: \.self) { trait in
                            Item(trait: trait)
                        }
                    } header: {
                        VStack(alignment: .leading) {
                            Text("Choose the traits you want to track.")
                                .fixedSize(horizontal: false, vertical: true)
                            
                            if first {
                                Text("You can always update your preferences in Settings.")
                                    .foregroundColor(.secondary)
                                    .font(.footnote)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.vertical)
                            }
                        }
                    }
                    .textCase(.none)
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
            .onReceive(cloud) {
                first = $0.settings.traits.isEmpty
            }
        }
    }
}
