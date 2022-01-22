import SwiftUI
import Selene

extension Track {
    struct Category: View {
        let trait: Trait
        
        var body: some View {
            Button {
                
            } label: {
                HStack {
                    Image(systemName: trait.image)
                        .font(.system(size: 18))
                        .foregroundColor(trait.color)
                    Text(trait.title)
                        .font(.callout)
                    Image(systemName: "checkmark.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                        .font(.title3.weight(.light))
                }
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .tint(.accentColor)
        }
    }
}
