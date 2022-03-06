import SwiftUI
import Dater
import Selene

extension Cal {
    struct Month: View {
        @Binding var selection: Int
        @Binding var detail: Bool
        let observatory: Observatory
        let month: [Days<Journal>.Item]
        let animation: Namespace.ID
        @State private var traits = [Trait]()
        
        var body: some View {
            Header(selection: $selection, observatory: observatory, month: month)
                .matchedGeometryEffect(id: "calendar", in: animation)
            
            TabView(selection: $selection) {
                ForEach(month, id: \.value) { day in
                    Item(day: day, traits: traits)
                        .tag(day.value)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onReceive(cloud) {
                traits = $0.settings.traits.sorted()
            }
            
            Button {
                detail = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    selection = 0
                }
            } label: {
                Image(systemName: "calendar.circle.fill")
                    .font(.system(size: 40).weight(.light))
                    .symbolRenderingMode(.hierarchical)
                    .frame(width: 45, height: 45)
                    .contentShape(Rectangle())
            }
            .padding(.bottom)
        }
    }
}
