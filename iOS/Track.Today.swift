import SwiftUI

extension Track {
    struct Today: View {
        @ObservedObject var status: Status
        let proxy: ScrollViewProxy
        let animation: Namespace.ID
        
        var body: some View {
            ZStack {
                VStack {
//                    Text("Log your day")
//                        .font(.body.weight(.medium))
//                        .foregroundStyle(.primary)
//                        .padding(.top, 30)
                    Spacer()
//
                    if !status.traits.isEmpty && status.traits.count <= (status.journal?.traits.count ?? 0) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 35).weight(.light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.accentColor)
                            .foregroundStyle(.primary)
                            .padding(.bottom, 2)
                        Text("Completed")
                            .font(.callout)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                    }
                }
                .allowsHitTesting(false)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        Spacer()
                            .frame(width: 10)
                        ForEach(status.traits, id: \.self) { trait in
                            Category(status: status, trait: trait, animation: animation)
                        }
                        Spacer()
                            .frame(width: 10)
                    }
                    .frame(maxHeight: .greatestFiniteMagnitude)
                }
            }
            .onAppear {
                if let previous = status.previous {
                    proxy.scrollTo(previous, anchor: .bottom)
                    status.previous = nil
                }
            }
        }
    }
}
