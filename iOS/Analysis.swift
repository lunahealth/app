import SwiftUI
import Selene

struct Analysis: View, Equatable {
    let observatory: Observatory
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        VStack {
            Chart(trait: .sleep, value: [.new : .bottom,
                                         .waxingCrescent : .low,
                                         .firstQuarter : .top,
                                         .waxingGibbous : .medium,
                                         .full : .top,
                                         .waningGibbous : .medium,
                                         .lastQuarter : .high,
                                         .waningCrescent : .medium])
                .background(Color(.tertiarySystemBackground))
                .shadow(color: .black.opacity(scheme == .dark ? 1 : 0.15), radius: 5)
            Spacer()
        }
        .background(Color(.secondarySystemBackground))
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
