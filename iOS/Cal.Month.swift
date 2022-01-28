import SwiftUI
import Dater
import Selene

extension Cal {
    struct Month: View {
        let month: [Days<Journal>.Item]
        @State private var selection = 0
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
                
                Header(month: month)
                
                TabView(selection: $selection) {
                    ForEach(month, id: \.value) { day in
                        Circle()
                            .tag(day.value)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }
}
