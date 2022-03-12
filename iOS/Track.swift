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
            } else if status.traits.isEmpty {
                Button {
                    status.preferences = true
                } label: {
                    Text("Adjust preferences")
                        .font(.callout)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .modifier(Shadowed(level: .medium))
            } else {
                VStack(spacing: 18) {
                    ForEach(status.traits, id: \.self) { trait in
                        Category(status: status, trait: trait, animation: animation)
                    }
                }
            }
        }
        .onChange(of: track) {
            guard $0 else { return }
            status.level = nil
            status.trait = nil
            status.refresh.send()
        }
        .sheet(isPresented: $status.preferences, content: Settings.Traits.init)
    }
}
