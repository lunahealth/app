import SwiftUI

extension Home {
    struct Info: View {
        @Binding var date: Date
        
        var body: some View {
            VStack {
                HStack {
                    Button {
                        date = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? .now
                    } label: {
                        Image(systemName: "chevron.left")
                            .frame(width: 60, height: 50)
                    }

                    Button {
                        date = .now
                    } label: {
                        VStack {
                            Text(date, format: .dateTime.weekday(.wide))
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(verbatim: date.formatted(date: .numeric, time: .omitted))
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text(relative)
                                .font(.footnote)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Button {
                        date = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? .now
                    } label: {
                        Image(systemName: "chevron.right")
                            .frame(width: 60, height: 50)
                    }
                }
                .padding(.top)
                Spacer()
            }
        }
        
        private var relative: String {
            if Calendar.current.isDateInToday(date) {
                return "Today"
            } else if Calendar.current.isDate(date, inSameDayAs: Calendar.current.date(byAdding: .day, value: -1, to: .now)!) {
                return "Yesterday"
            } else if Calendar.current.isDate(date, inSameDayAs: Calendar.current.date(byAdding: .day, value: 1, to: .now)!) {
                return "Tomorrow"
            } else {
                return date.formatted(.relative(presentation: .named, unitsStyle: .wide))
            }
        }
    }
}
