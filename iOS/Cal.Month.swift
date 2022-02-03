import SwiftUI
import Dater
import Selene

extension Cal {
    struct Month: View, Equatable {
        @Binding var selection: Int
        weak var observatory: Observatory!
        let month: [Days<Journal>.Item]
        @State private var traits = [Trait]()
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            VStack(spacing: 0) {
                Header(selection: $selection, observatory: observatory, month: month)
                
                TabView(selection: $selection) {
                    ForEach(month, id: \.value) { day in
                        Item(day: day, traits: traits)
                            .tag(day.value)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                        .font(.callout.weight(.medium))
                        .padding(.horizontal, 10)
                        .contentShape(Rectangle())
                }
                .tint(.accentColor)
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .padding(.bottom, 30)
            }
            .onReceive(cloud) {
                traits = $0.settings.traits.sorted()
            }
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            true
        }
    }
}
