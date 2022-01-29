import SwiftUI
import Dater
import Selene

extension Cal {
    struct Month: View {
        @Binding var selection: Int
        weak var observatory: Observatory!
        let month: [Days<Journal>.Item]
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                        .frame(width: 42)
                    Spacer()
                    
                    if selection > 0 && selection <= month.count {
                        Text(month[selection - 1].today
                             ? "Today"
                             : month[selection - 1].content.date.offset)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .padding(.top, 10)
                    }
                    
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30).weight(.light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.secondary)
                            .frame(width: 32, height: 36)
                            .padding([.top, .trailing], 10)
                            .contentShape(Rectangle())
                    }
                }
                
                Header(selection: $selection, observatory: observatory, month: month)
                
                TabView(selection: $selection) {
                    ForEach(month, id: \.value) { day in
                        Item(day: day)
                            .tag(day.value)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }
}
