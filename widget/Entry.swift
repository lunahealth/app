import WidgetKit
import Selene

struct Entry: TimelineEntry {
    let moon: Moon
    let date = Date.now
}
