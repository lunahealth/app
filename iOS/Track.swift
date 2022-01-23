import SwiftUI
import Selene

struct Track: View {
    @StateObject private var status = Status()
    @Namespace private var animation
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollViewReader { proxy in
            if let selected = status.selected {
                Detail(trait: selected, animation: animation) {
                    status.previous = selected
                    withAnimation(.easeInOut(duration: 0.3)) {
                        status.selected = nil
                    }
                }
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Spacer()
                            .frame(width: 16)
                        ForEach(Trait.allCases, id: \.self) { trait in
                            Category(trait: trait, animation: animation) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    status.selected = trait
                                }
                            }
                        }
                        Spacer()
                            .frame(width: 16)
                    }
                    .frame(maxHeight: .greatestFiniteMagnitude)
                }
                .onAppear {
                    if let previous = status.previous {
                        proxy.scrollTo(previous, anchor: .bottom)
                    }
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
