import SwiftUI
import Selene

extension Track {
    struct Detail: View {
        let status: Track.Status
        let trait: Trait
        let animation: Namespace.ID
        
        var body: some View {
            VStack {
                Heading(status: status, trait: trait, animation: animation)
                Spacer()
                HStack(spacing: 0) {
                    ForEach(Level.allCases, id: \.self) { level in
                        Item(status: status, trait: trait, level: level, animation: animation)
                    }
                }
                Spacer()
            }
        }
    }
}
