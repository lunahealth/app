import SwiftUI
import Selene

extension Analysis.Item {
    struct Display: View {
        let value: [Moon.Phase : Level]
        private let moonImage = Image("MoonMini")
        private let shadowImage = Image("ShadowMini")
        
        var body: some View {
            Canvas { context, size in
                let width = size.width / .init(Moon.Phase.allCases.count)
                var x = width / 2
                
                Moon.Phase.allCases.forEach { phase in
                    context.drawLayer { layer in
                        layer.draw(phase: phase,
                                   image: moonImage,
                                   shadow: shadowImage,
                                   radius: 7,
                                   center: .init(x: x, y: 180))
                    }
                    x += width
                }
            }
        }
    }
}
