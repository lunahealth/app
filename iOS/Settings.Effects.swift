import SwiftUI
import Selene

extension Settings {
    struct Effects: View {
        @AppStorage(Defaults.haptics.rawValue) private var haptics = true
        @AppStorage(Defaults.sounds.rawValue) private var sounds = true
        
        var body: some View {
            Section("Effects") {
                Toggle(isOn: $haptics) {
                    Label("Haptics", systemImage: "rectangle.and.hand.point.up.left")
                        .foregroundColor(.primary)
                }
                Toggle(isOn: $sounds) {
                    Label("Sounds", systemImage: "speaker.wave.1")
                        .foregroundColor(.primary)
                }
            }
            .headerProminence(.increased)
            .toggleStyle(SwitchToggleStyle(tint: .accentColor))
        }
    }
}
