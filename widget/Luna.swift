import SwiftUI
import WidgetKit

struct Luna: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Moon", provider: Provider(), content: Content.init(entry:))
            .configurationDisplayName("The Moon Widget")
            .description("Follow The Moon from your Home Screen")
            .supportedFamilies([.systemSmall])
    }
}
