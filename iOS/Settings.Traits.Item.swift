import SwiftUI
import Selene

extension Settings.Traits {
    struct Item: View {
        @Binding var trait: Selene.Settings.Option
        
        var body: some View {
            Toggle(isOn: $trait.active) {
                HStack {
                    Image(trait.id.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 20, maxHeight: 20)
                        .foregroundColor(trait.active ? trait.id.color : .init(.tertiaryLabel))
                    Text(trait.id.title)
                        .font(.callout)
                        .foregroundColor(trait.active ? .primary : .secondary)
                    + Text("\n" + trait.id.description)
                        .foregroundColor(trait.active ? .secondary : .init(.tertiaryLabel))
                        .font(.footnote)
                }
                .offset(x: -30)
            }
        }
    }
}
