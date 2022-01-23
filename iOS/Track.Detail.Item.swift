import SwiftUI
import Selene

extension Track.Detail {
    struct Item: View {
        let index: Int
        let trait: Trait
        let selected: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                VStack {
                    ZStack {
                        Circle()
                            .fill(selected ? .secondary : .quaternary)
                            .foregroundColor(selected ? .accentColor : .secondary)
                            .frame(width: 44, height: 44)
                        Image(systemName: symbol)
                            .font(.system(size: 16).weight(.light))
                            .foregroundColor(selected ? .primary : .secondary)
                    }
                    Text(trait.levels[index])
                        .font(.caption2)
                        .foregroundColor(selected ? .primary : .secondary)
                }
                .frame(width: 70)
            }
        }
        
        private var symbol: String {
            switch index {
            case 0:
                return "minus"
            case 1:
                return "chevron.down"
            case 2:
                return "chevron.up.chevron.down"
            case 3:
                return "chevron.up"
            default:
                return "arrow.up"
            }
        }
    }
}
