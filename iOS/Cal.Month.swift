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
            .safeAreaInset(edge: .top, spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        Text(Calendar.current.date(from: .init(year: month.year, month: month.month))!,
                             format: .dateTime.year().month(.wide))
                            .font(.callout.weight(.medium))
                            .foregroundStyle(.primary)
                        
                        if selection > 0 && selection <= month.count {
                            Text(month[selection - 1].today
                                 ? "Today"
                                 : month[selection - 1].content.date.offset)
                                .font(.callout)
                                .foregroundStyle(.primary)
                                .padding(.top, 10)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    Rectangle()
                        .fill(.tertiary)
                        .frame(height: 1)
                }
                .background(.ultraThinMaterial)
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
