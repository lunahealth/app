import SwiftUI
import Selene

extension Track.Detail {
    struct Item: View {
        @ObservedObject var status: Track.Status
        let trait: Trait
        let level: Level
        let animation: Namespace.ID
        
        var body: some View {
            Button {
                Task {
                    await cloud.track(trait: trait, level: level)
                }
                withAnimation(.easeInOut(duration: 0.35)) {
                    status.level = level
                }
            } label: {
                VStack {
                    Track.Item(trait: trait, level: level, selected: selected, animation: animation)
                        .font(.system(size: 18).weight(.medium))
                        .frame(width: 50, height: 50)
                        .modifier(Shadowed())
                    Text(level.title(for: trait))
                        .font(.caption2)
                        .foregroundColor(.primary)
                }
                .frame(width: 70)
            }
        }
        
        var selected: Bool {
            status.journal?.traits[trait] == level
        }
    }
}
