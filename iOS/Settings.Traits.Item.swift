import SwiftUI
import Selene

extension Settings.Traits {
    struct Item: View {
        let trait: Trait
        @State private var active = false
        
        var body: some View {
            Toggle(isOn: $active) {
                HStack {
                    Image(trait.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 20, maxHeight: 20)
                        .foregroundColor(active ? trait.color : .init(.tertiaryLabel))
                    Text(trait.title)
                        .font(.callout)
                        .foregroundColor(active ? .primary : .secondary)
                    + Text("\n" + trait.description)
                        .foregroundColor(active ? .secondary : .init(.tertiaryLabel))
                        .font(.footnote)
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
