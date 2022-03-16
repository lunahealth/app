import SwiftUI
import Selene

struct Settings: View {
    private let all = Trait.allCases.sorted()
    
    var body: some View {
        List {
            Section("What to track") {
                ForEach(all, id: \.self) { trait in
                    Item(trait: trait)
                }
            }
        }
        .toggleStyle(SwitchToggleStyle(tint: .accentColor))
    }
}
