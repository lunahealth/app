import SwiftUI
import Selene

extension Settings.Preferences {
    struct Bar: View {
        @Binding var traits: [Selene.Settings.Option]
        
        var body: some View {
            Button {
                traits = traits
                    .map {
                        var item = $0
                        item.active = false
                        return item
                    }
            } label: {
                Image(systemName: "square")
                    .foregroundColor(.pink)
                    .contentShape(Rectangle())
                    .allowsHitTesting(false)
            }
            
            Button {
                traits = traits
                    .map {
                        var item = $0
                        item.active = true
                        return item
                    }
            } label: {
                Image(systemName: "checkmark.square")
                    .foregroundColor(.blue)
                    .contentShape(Rectangle())
                    .allowsHitTesting(false)
            }
        }
    }
}
