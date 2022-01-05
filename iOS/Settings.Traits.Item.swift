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
                        .foregroundColor(trait.id.color)
                    Text(trait.id.title)
                        .font(.callout)
                    + Text("\n" + trait.id.description)
                        .foregroundColor(.secondary)
                        .font(.footnote)
                }
                .offset(x: -50)
            }
        }
    }
}
