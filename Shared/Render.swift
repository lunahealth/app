import SwiftUI

struct Render {
    let image: Image
    let shadow: Image
    let radius: Double
    let blur: Bool
    
    static let regular = Self(image: .init("Moon"), shadow: .init("Shadow"), radius: 34, blur: true)
    static let mini = Self(image: .init("MoonMini"), shadow: .init("ShadowMini"), radius: 8, blur: false)
}
