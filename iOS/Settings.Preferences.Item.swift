import SwiftUI
import Selene

extension Settings.Preferences {
    struct Item: View {
        @Binding var trait: Selene.Settings.Option
        
        var body: some View {
            Toggle(isOn: $trait.active) {
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
    }
}
