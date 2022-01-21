import SwiftUI
import Selene

struct Track: View {
    @StateObject private var status = Status()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .frame(width: 50, height: 50)
                        .contentShape(Rectangle())
                }
            }
            Spacer()
        }
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
