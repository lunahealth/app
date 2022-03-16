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
                    List(Level.allCases.reversed(), id: \.self) { level in
                        Button {
                            Task {
                                await cloud.track(trait: trait, level: level)
                            }
                            dismiss()
                        } label: {
                            Item(trait: trait, level: level, selected: journal?.traits[trait] == level)
                        }
                        .id(level)
                        .listRowBackground(Color.clear)
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
