import SwiftUI
import Selene

extension Home {
    struct Info: View {
        @Binding var date: Date
        @Binding var moon: Moon
        
        var body: some View {
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    Button {
                        date = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? .now
                    } label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.title2)
                            .symbolRenderingMode(.hierarchical)
                            .frame(width: 50, height: 50)
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
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.title2)
                            .symbolRenderingMode(.hierarchical)
                            .frame(width: 50, height: 50)
                    }
                }
                .padding(.top)
                
                Text(moon.fraction, format: .number)
                    .font(.callout.monospaced())
                + Text("%  ")
                    .foregroundColor(.secondary)
                    .font(.caption2)
                + Text(phase)
                    .font(.callout)
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
                return date.formatted(.relative(presentation: .named, unitsStyle: .wide)).capitalized
            }
        }
        
        private var phase: String {
            switch moon.phase {
            case .new:
                return "New Moon"
            case .waxingCrescent:
                return "Waxing Crescent"
            case .firstQuarter:
                return "First Quarter"
            case .waxingGibbous:
                return "Waxing Gibbous"
            case .full:
                return "Full Moon"
            case .waningGibbous:
                return "Waning Gibbous"
            case .lastQuarter:
                return "Last Quarter"
            case .waningCrescent:
                return "Waning Crescent"
            }
        }
    }
}
