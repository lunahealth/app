import WidgetKit
import Selene

struct Provider: TimelineProvider {
    private let observatory = Observatory()
    
    func placeholder(in: Context) -> Entry {
        .init(moon: observatory.moon(for: .now))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        completion(.init(moon: observatory.moon(for: .now)))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        if let coords = Defaults.coordinates {
            observatory.update(to: coords)
        }
        completion(.init(entries: [.init(moon: observatory.moon(for: .now))],
                         policy: .after(Calendar.current.startOfDay(
                            for: Calendar.current.date(byAdding: .day, value: 1, to: .now) ?? .now))))
    }
}
