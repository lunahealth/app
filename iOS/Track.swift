import SwiftUI
import Selene

struct Track: View {
    @StateObject private var status = Status()
    @Namespace private var animation
    
    var body: some View {
        ScrollViewReader { proxy in
            if let level = status.level, let trait = status.trait {
                Leveled(status: status, trait: trait, level: level, animation: animation)
            } else if let selected = status.trait {
                Detail(status: status, trait: selected, animation: animation)
            } else {
                ZStack {
                    VStack {
                        Text("Track")
                            .padding(.top, 30)
                        Text("Today's traits")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        Spacer()
                        
                        if !status.traits.isEmpty && status.traits.count <= (status.journal?.traits.count ?? 0) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title.weight(.light))
                                .symbolRenderingMode(.hierarchical)
                                .foregroundColor(.blue)
                            Text("You tracked Today,\ncome back tomorrow.")
                                .font(.caption)
                                .foregroundStyle(.primary)
                                .multilineTextAlignment(.center)
                                .padding(.vertical)
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
                    }
                }
            }
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .background(.thinMaterial)
        .sheet(isPresented: $status.preferences, content: Settings.Traits.init)
    }
}
