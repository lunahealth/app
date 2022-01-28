import SwiftUI
import Dater
import Selene

extension Cal {
    struct Month: View {
        @Binding var selection: Int
        let month: [Days<Journal>.Item]
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            VStack {
                HStack(spacing: 0) {
                    Spacer()
                        .frame(width: 50)
                    Spacer()
                    Text("Today")
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30).weight(.light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.secondary)
                            .frame(width: 50, height: 55)
                            .contentShape(Rectangle())
                    }
                }
                
                Header(selection: $selection, month: month)
                
                TabView(selection: $selection) {
                    ForEach(month, id: \.value) { day in
                        Item(day: day)
                            .tag(day.value - 1)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }
}
