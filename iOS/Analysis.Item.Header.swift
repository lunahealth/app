import SwiftUI
import Selene

extension Analysis.Item {
    struct Header: View {
        let trait: Trait
        
        var body: some View {
            HStack {
                ZStack {
                    Capsule()
                        .fill(Color.accentColor.opacity(0.2))
                    Label(trait.title, systemImage: trait.symbol)
                        .font(.callout)
                        .foregroundColor(.accentColor)
                        .padding(.horizontal)
                }
                .frame(height: 38)
                .fixedSize(horizontal: true, vertical: false)
                .padding(.leading)
                Spacer()
            }
        }
    }
}
