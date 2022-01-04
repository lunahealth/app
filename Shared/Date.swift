import Foundation

extension Date {
    var relativeDays: String {
        if Calendar.current.isDateInToday(self) {
            return "Today"
        } else if Calendar.current.isDate(self, inSameDayAs: Calendar.current.date(byAdding: .day, value: -1, to: .now)!) {
            return "Yesterday"
        } else if Calendar.current.isDate(self, inSameDayAs: Calendar.current.date(byAdding: .day, value: 1, to: .now)!) {
            return "Tomorrow"
        } else {
            return self.formatted(.relative(presentation: .named, unitsStyle: .wide)).capitalized
        }
    }
}
