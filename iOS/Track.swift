import SwiftUI
import Selene

struct Track: View {
    let track: Bool
    @StateObject private var status = Status()
    @Namespace private var animation
    
    var body: some View {
        VStack(spacing: 0) {
            if let level = status.level, let trait = status.trait {
                Leveled(status: status, trait: trait, level: level, animation: animation)
            } else if let selected = status.trait {
                Detail(status: status, trait: selected, animation: animation)
            } else {
                ForEach(status.traits, id: \.self) { trait in
                    Category(status: status, trait: trait, animation: animation)
                }
            }
        }
        .onChange(of: track) {
            if $0 && status.first && status.traits.isEmpty {
                status.first = false
                status.preferences = true
            }
        }
        .sheet(isPresented: $status.preferences, content: Settings.Traits.init)
    }
}
