import SwiftUI
import Selene

extension Track {
    struct Today: View {
        @ObservedObject var status: Status
        let moon: Moon
        let proxy: ScrollViewProxy
        let animation: Namespace.ID
        
        var body: some View {
            ZStack {
                VStack {
                    Canvas { context, size in
                        context.draw(moon: moon,
                                     image: .init("MoonSmall"),
                                     shadow: .init("ShadowSmall"),
                                     radius: 13,
                                     center: .init(x: size.width / 2, y: size.height / 2))
                    }
                    .frame(width: 30, height: 30)
                    .padding(.top, 30)
                    Text("Today")
                        .font(.body.weight(.medium))
                        .foregroundStyle(.secondary)
                    Spacer()
                    
                    if !status.traits.isEmpty && status.traits.count <= (status.journal?.traits.count ?? 0) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 35).weight(.light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.primary)
                            .padding(.bottom, 2)
                        Text("Completed")
                            .font(.callout)
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                    }
                }
                .allowsHitTesting(false)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 20) {
                        Spacer()
                            .frame(width: 20)
                        ForEach(status.traits, id: \.self) { trait in
                            Category(status: status, trait: trait, animation: animation)
                        }
                        Spacer()
                            .frame(width: 20)
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
