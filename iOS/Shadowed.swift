import SwiftUI

struct Shadowed: ViewModifier {
    let level: Level
    @Environment(\.colorScheme) private var scheme
    
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(scheme == .dark ? 1 : level.light), radius: level.radius)
    }
}
