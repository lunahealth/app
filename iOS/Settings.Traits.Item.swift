import SwiftUI
import Selene

extension Settings.Traits {
    struct Item: View {
        let trait: Trait
        @State private var active = false
        
        var body: some View {
            Toggle(isOn: $active) {
                HStack {
                    Image(systemName: trait.symbol)
                        .font(.system(size: 18).weight(.medium))
                        .foregroundColor(active ? trait.color : .init(.tertiaryLabel))
                        .frame(width: 40, height: 48)
                    Text(trait.title)
                        .font(.callout)
                        .foregroundColor(active ? .primary : .secondary)
                    + Text("\n" + trait.description)
                        .font(.footnote)
                        .foregroundColor(active ? .secondary : .init(.tertiaryLabel))
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
