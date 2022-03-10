import SwiftUI
import Selene

struct Track: View {
    @StateObject private var status = Status()
    @Namespace private var animation
    
    var body: some View {
        VStack(spacing: 0) {
            if let level = status.level, let trait = status.trait {
                Leveled(status: status, trait: trait, level: level, animation: animation)
            } else if let selected = status.trait {
                Detail(status: status, trait: selected, animation: animation)
            } else {
                Today(status: status, animation: animation)
            }
        }
        .sheet(isPresented: $status.preferences, content: Settings.Traits.init)
    }
}
