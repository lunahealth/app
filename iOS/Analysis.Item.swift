import SwiftUI
import Selene

extension Analysis {
    struct Item: View {
        let trait: Trait
        let value: [Moon.Phase : Level]
        
        var body: some View {
            VStack(spacing: 0) {
                Header(trait: trait)
                    .padding(.vertical)
                
                Rectangle()
                    .fill(Color(.secondarySystemFill))
                    .frame(height: 1)
                
                ZStack {
                    Rectangle()
                        .fill(Color(.systemBackground))
                    Display(value: value)
                }
                .frame(height: 200)
                
                Rectangle()
                    .fill(Color(.secondarySystemFill))
                    .frame(height: 1)
            }
        }
    }
}
