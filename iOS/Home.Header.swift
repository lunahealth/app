import SwiftUI
import Selene

extension Home {
    struct Header: View {
        @Binding var date: Date
        let observatory: Observatory
        let moon: Moon
        let track: Bool
        @State private var calendar = false
        @State private var completed = false
        
        var body: some View {
            HStack(spacing: 0) {
                if !track {
                    Button {
                        date = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? .now
                    } label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 26).weight(.light))
                            .frame(width: 40, height: 40)
                            .contentShape(Rectangle())
                    }
                }
                
                VStack(alignment: track ? .leading : .center, spacing: 0) {
                    Spacer()
                    if Calendar.current.isDateInToday(date) {
                        Text("Today")
                            .font(.callout.weight(.medium))
                            .padding(.bottom, 3)
                    } else {
                        Text(date, format: .dateTime.year(.defaultDigits).month(.defaultDigits).day(.defaultDigits).weekday(.abbreviated))
                            .font(.callout.weight(.medium))
                            .padding(.bottom, 3)
                    }
                    
                    Text(moon.fraction, format: .number)
                        .font(.largeTitle.weight(.medium).monospacedDigit())
                    + Text("%")
                        .font(.title3.weight(.medium).monospacedDigit())
                    
                    Text(moon.phase.name)
                        .font(.footnote.weight(.medium))
                        .padding(.top, 3)
                }
                .frame(width: 170, height: 90)
                .modifier(ShadowedHard())
                
                if track {
                    Spacer()
                    if completed {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 32).weight(.light))
                            .padding(.trailing)
                    }
                } else {
                    Button {
                        date = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? .now
                    } label: {
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.system(size: 26).weight(.light))
                            .frame(width: 40, height: 40)
                            .contentShape(Rectangle())
                    }
                }
                
//                Spacer()
//
//                Button {
//                    calendar = true
//                } label: {
//                    Image(systemName: "calendar")
//                        .font(.system(size: 22).weight(.light))
//                        .tint(.primary)
//                        .frame(width: 40, height: 40)
//                        .contentShape(Rectangle())
//                }
//                .opacity(track ? 0 : 1)
//                .animation(.easeInOut(duration: 0.3), value: track)
//                .sheet(isPresented: $calendar) {
//                    Cal(observatory: observatory)
//                        .equatable()
//                }
//
                
            }
            .symbolRenderingMode(.hierarchical)
            .foregroundColor(.white)
            .animation(.easeInOut(duration: 0.4), value: track)
            .onReceive(cloud) {
                let traits = $0.settings.traits
                let journal = $0[.now]
                completed = !traits.isEmpty && traits.count <= (journal?.traits.count ?? 0)
            }
        }
    }
}
