import SwiftUI
import Selene

struct Settings: View {
    private let all = Trait.allCases.sorted()
    
    var body: some View {
        NavigationView {
            List(all, id: \.self, rowContent: Item.init(trait:))
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .navigationTitle("Preferences")
        }
    }
}
