import SwiftUI
import Selene

extension Home {
    struct Header: View {
        @Binding var date: Date
        @Binding var track: Bool
        let observatory: Observatory
        let moon: Moon
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
                            .padding(.top, 5)
                    }
                }
                
                VStack(alignment: track ? .leading : .center, spacing: 0) {
                    Spacer()
                    if !Calendar.current.isDateInToday(date) {
                        Text(date, format: .dateTime.year(.defaultDigits).month(.defaultDigits).day(.defaultDigits).weekday(.abbreviated))
                            .font(.system(size: 12).weight(.medium))
                    }
                    
                    Text(moon.fraction, format: .number)
                        .font(.system(size: 50).weight(.light))
                    + Text("%")
                        .font(.system(size: 14).weight(.medium))
                    
                    Text(moon.phase.name)
                        .font(.system(size: 16).weight(.medium))
                        .padding(.top, 2)
                }
                .frame(width: 150, height: 105)
                .modifier(Shadowed(level: .maximum))
                
                if track {
                    
                    Spacer()
                    VStack(alignment: .trailing) {
                        Button {
                            track = false
                        } label: {
                            Text("Done")
                                .fontWeight(.medium)
                                .padding(.horizontal, 2)
                        }
                        .buttonStyle(.bordered)
                        .tint(.white)
                        .buttonBorderShape(.capsule)
                        
                        Label("Completed!", systemImage: "checkmark.circle.fill")
                            .font(.body)
                            .imageScale(.large)
                            .modifier(Shadowed(level: .medium))
                            .padding(.top, 5)
                            .opacity(completed ? 1 : 0)
                            .animation(.easeInOut(duration: 0.4), value: completed)
                    }
                    .padding(.trailing)
                } else {
                    Button {
                        date = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? .now
                    } label: {
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.system(size: 26).weight(.light))
                            .frame(width: 40, height: 40)
                            .contentShape(Rectangle())
                            .padding(.top, 5)
                    }
                }
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
