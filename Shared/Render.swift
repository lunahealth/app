import SwiftUI

struct Render {
    let image: Image
    let shadow: Image
    let radius: Double
    let blur: Bool
    
    static let regular = Self(image: .init("Moon"), shadow: .init("Shadow"), radius: 34, blur: true)
    static let small = Self(image: .init("MoonSmall"), shadow: .init("ShadowSmall"), radius: 18, blur: false)
    static let mini = Self(image: .init("MoonMini"), shadow: .init("ShadowMini"), radius: 8, blur: false)
}
