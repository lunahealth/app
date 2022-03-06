import SwiftUI
import Selene

struct Analysis: View, Equatable {
    let observatory: Observatory
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var scheme
    @State private var since = Analysing.all
    
    var body: some View {
        VStack {
            ZStack {
                Color(.tertiarySystemBackground)
                    .shadow(color: .black.opacity(scheme == .dark ? 1 : 0.1), radius: 3)
                Chart(trait: .sleep, value: [.new : .bottom,
                                             .waxingCrescent : .low,
                                             .firstQuarter : .top,
                                             .waxingGibbous : .medium,
                                             .full : .top,
                                             .waningGibbous : .medium,
                                             .lastQuarter : .high,
                                             .waningCrescent : .medium])
            }
            .frame(height: 230)
            Picker("Since", selection: $since) {
                Text("All")
                    .tag(Analysing.all)
                Text("Last month")
                    .tag(Analysing.month)
            }
            .pickerStyle(.segmented)
            .padding()
            Spacer()
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.down.circle.fill")
                    .font(.system(size: 32).weight(.light))
                    .symbolRenderingMode(.hierarchical)
                    .frame(width: 40, height: 40)
                    .contentShape(Rectangle())
            }
            .padding(.bottom)
        }
        .background(Color(.secondarySystemBackground))
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
