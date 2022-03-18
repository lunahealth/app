import SwiftUI
import Selene

extension Track {
    struct Levels: View {
        @Binding var journal: Journal?
        let trait: Trait
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            NavigationView {
                ScrollViewReader { proxy in
                    ScrollView {
                        Spacer()
                            .frame(height: 20)
                        
                        ForEach(Level.allCases.reversed(), id: \.self) { level in
                            Button {
                                Task {
                                    await cloud.track(trait: trait, level: level)
                                }
                                dismiss()
                            } label: {
                                Item(trait: trait, level: level, selected: journal?.traits[trait] == level)
                            }
                            .id(level)
                            .buttonStyle(.plain)
                            .padding(.vertical)
                        }
                        
                        Button {
                            Task {
                                await cloud.remove(trait: trait)
                            }
                            dismiss()
                        } label: {
                            Text("Cancel")
                        }
                        .buttonStyle(.bordered)
                        .padding()
                    }
                    .onAppear {
                        if let trait = journal?.traits[trait] {
                            proxy.scrollTo(trait, anchor: .center)
                        }
                    }
                    .navigationTitle(trait.title)
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}
