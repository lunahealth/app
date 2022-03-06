import SwiftUI
import Selene

struct Analysis: View, Equatable {
    let observatory: Observatory
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var scheme
    
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
            Spacer()
        }
        .background(Color(.secondarySystemBackground))
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
