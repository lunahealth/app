import SwiftUI

struct ShadowedHard: ViewModifier {
    @Environment(\.colorScheme) private var scheme
    
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(scheme == .dark ? 1 : 0.4), radius: 4)
    }
}
