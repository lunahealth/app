import SwiftUI
import Selene

struct Analysis: View, Equatable {
    weak var observatory: Observatory!
    @State private var traits = [Trait]()
    @State private var analysis = [Trait : [Moon.Phase : Level]]()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(traits, id: \.self) {
                    Item(trait: $0, value: analysis[$0] ?? [:])
                        .padding(.top)
                }
            }
            .background(Color(.secondarySystemBackground))
            .navigationTitle("Analysis")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24).weight(.light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.secondary)
                            .frame(width: 26, height: 40)
                            .padding(.leading)
                            .contentShape(Rectangle())
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .task {
            traits = await cloud.model.settings.traits.sorted()
            analysis = await cloud.analysis {
                observatory.moon(for: $0).phase
            }
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
