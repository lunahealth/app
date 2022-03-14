import SwiftUI
import Selene

extension Settings {
    struct Effects: View {
        @AppStorage(Defaults.haptics.rawValue) private var haptics = true
        
        var body: some View {
            Section("Effects") {
                Toggle(isOn: $haptics) {
                    Label("Haptics", systemImage: "rectangle.and.hand.point.up.left")
                        .foregroundColor(.primary)
                }
            }
            .headerProminence(.increased)
            .toggleStyle(SwitchToggleStyle(tint: .accentColor))
        }
    }
}
