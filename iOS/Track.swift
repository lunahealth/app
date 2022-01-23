import SwiftUI
import Selene

struct Track: View {
    @StateObject private var status = Status()
    @Namespace private var animation
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            if let selected = status.selected {
                Detail(trait: selected, animation: animation)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Trait.allCases, id: \.self) { trait in
                            Category(trait: trait, animation: animation) {
                                withAnimation(.easeInOut(duration: 0.7)) {
                                    status.selected = trait
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .frame(maxHeight: .greatestFiniteMagnitude)
                }
            }
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .background(.ultraThinMaterial)
        .sheet(isPresented: $status.preferences, onDismiss: {
            Task {
                await status.update()
            }
        }, content: Settings.Traits.init)
        .task {
            await status.update()
        }
    }
}
