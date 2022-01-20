import SwiftUI
import Selene

extension TrackOld {
    struct Content: View {
        @StateObject var status: Status
        let traits: [Trait]
        
        var body: some View {
            ScrollView {
                ForEach($status.items, content: Slide.init)
            }
            .onChange(of: traits) {
                status.traits.send($0)
            }
            .onAppear {
                status.traits.send(traits)
            }
        }
    }
}
