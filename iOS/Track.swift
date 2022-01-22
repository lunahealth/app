import SwiftUI
import Selene

struct Track: View {
    @StateObject private var status = Status()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 25))
                        .symbolRenderingMode(.hierarchical)
                        .frame(width: 40, height: 40)
                        .contentShape(Rectangle())
                        .padding([.top, .trailing], 15)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Trait.allCases, id: \.self) {
                        Category(trait: $0)
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical)
            
            Spacer()
            
            Text("Select a trait to track")
                .font(.footnote)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .background(.thinMaterial)
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
