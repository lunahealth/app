import SwiftUI
import Selene

extension Analysis {
    struct Display: View {
        @Binding var since: Analysing
        let analysis: [Trait : [Moon.Phase : Level]]
        let trait: Trait?
        
        var body: some View {
            ZStack(alignment: .top) {
                Color(.tertiarySystemBackground)
                if let trait = trait, let analysis = analysis[trait] {
                    Chart(trait: trait, value: analysis)
                        .equatable()
                        .id(analysis)
                }
                
//                HStack {
//                    Spacer()
//                        .frame(width: 45)
//                    Spacer()
//                    Picker("Since", selection: $since) {
//                        Text("All")
//                            .tag(Analysing.all)
//                        Text("Month")
//                            .tag(Analysing.month)
//                        Text("Fortnight")
//                            .tag(Analysing.fortnight)
//                    }
//                    .pickerStyle(.segmented)
//                    .frame(width: 250)
//                    Spacer()
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "xmark")
//                            .font(.system(size: 14))
//                            .frame(width: 45, height: 45)
//                            .contentShape(Rectangle())
//                            .foregroundColor(.secondary)
//                    }
//                }
            }
        }
    }
}
