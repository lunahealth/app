import Foundation

extension Date {
    var offset: String {
        if Calendar.current.isDate(self, inSameDayAs: Calendar.current.date(byAdding: .day, value: -1, to: .now)!) {
            return "yesterday"
        } else if Calendar.current.isDate(self, inSameDayAs: Calendar.current.date(byAdding: .day, value: 1, to: .now)!) {
            return "tomorrow"
        } else {
            return self.formatted(.relative(presentation: .named, unitsStyle: .wide))
        }
    }
}
