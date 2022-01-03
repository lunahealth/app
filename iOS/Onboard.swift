import SwiftUI
import Selene

struct Onboard: View {
    @State private var traits = [Selene.Settings.Option]()
    @State private var mode = EditMode.active
    @State private var first = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach($traits) { trait in
                        Toggle(isOn: trait.active) {
                            Group {
                                Text(trait.id.title)
                                    .font(.callout)
                                + Text("\n" + trait.id.description)
                                    .foregroundColor(.secondary)
                                    .font(.footnote)
                            }
                            .offset(x: -42)
                        }
                    }
                    .onMove { index, destination in
                        traits.move(fromOffsets: index, toOffset: destination)
                    }
                } header: {
                    Text("Choose and order the traits that you want to track every day with Moon Health.")
                        .fixedSize(horizontal: false, vertical: true)
                } footer: {
                    if first {
                        Text("You can always update your preferences in Settings.")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .textCase(.none)
            }
            .navigationTitle("Preferences")
            .navigationBarTitleDisplayMode(.inline)
            .toggleStyle(SwitchToggleStyle(tint: .mint))
            .environment(\.editMode, $mode)
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
                            .allowsHitTesting(false)
                            .contentShape(Rectangle())
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .onChange(of: traits) { _ in
            print("change")
        }
        .onReceive(cloud.first()) {
            first = $0.settings.traits.isEmpty
        }
        .task {
            traits = Trait
                .allCases
                .sorted {
                    $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
                }
                .map {
                    .init(trait: $0, active: true)
                }
        }
    }
}
