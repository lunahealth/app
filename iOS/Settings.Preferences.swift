import SwiftUI
import Selene

extension Settings {
    struct Preferences: View {
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
                        VStack(alignment: .leading) {
                            Text("Choose the traits that you want to track every day with Moon Health and drag to rearrenge them.")
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
                                .contentShape(Rectangle())
                                .allowsHitTesting(false)
                        }
                    }
                    
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button {
                            traits = traits
                                .map {
                                    var item = $0
                                    item.active = false
                                    return item
                                }
                        } label: {
                            Image(systemName: "square")
                                .foregroundColor(.pink)
                                .contentShape(Rectangle())
                                .allowsHitTesting(false)
                        }
                        
                        Button {
                            traits = traits
                                .map {
                                    var item = $0
                                    item.active = true
                                    return item
                                }
                        } label: {
                            Image(systemName: "checkmark.square")
                                .foregroundColor(.blue)
                                .contentShape(Rectangle())
                                .allowsHitTesting(false)
                        }
                    }
                }
            }
            .navigationViewStyle(.stack)
            .onChange(of: traits) { updated in
                Task {
                    await cloud.update(traits: updated)
                }
            }
            .onReceive(cloud) {
                if $0.settings.traits.isEmpty {
                    first = true
                    traits = Trait
                        .allCases
                        .sorted {
                            $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
                        }
                        .map {
                            .init(trait: $0, active: true)
                        }
                } else {
                    traits = $0.settings.traits
                }
            }
        }
    }
}
