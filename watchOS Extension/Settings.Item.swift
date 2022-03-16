import SwiftUI
import Selene

extension Settings {
    struct Item: View {
        let trait: Trait
        @State private var active = false
        
        var body: some View {
            Toggle(isOn: $active) {
                HStack(spacing: 0) {
                    Image(systemName: trait.symbol)
                        .font(.system(size: 13).weight(.medium))
                        .foregroundColor(active ? trait.color : .secondary)
                        .frame(width: 30, height: 40)
                    Text(trait.title)
                        .font(.footnote)
                        .foregroundColor(active ? .primary : .secondary)
                }
            }
            .onReceive(cloud) {
                active = $0.settings.traits.contains(trait)
            }
            .onChange(of: active) { mode in
                Task {
                    await cloud.toggle(trait: trait, mode: mode)
                }
            }
        }
    }
}
