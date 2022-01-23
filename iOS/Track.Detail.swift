import SwiftUI
import Selene

extension Track {
    struct Detail: View {
        let trait: Trait
        let animation: Namespace.ID
        let back: () -> Void
        @State private var selected: Int?
        
        var body: some View {
            ZStack {
                VStack {
                    ZStack {
                        HStack {
                            Button(action: back) {
                                Image(systemName: "arrow.backward.circle.fill")
                                    .font(.system(size: 26).weight(.light))
                                    .symbolRenderingMode(.hierarchical)
                                    .frame(width: 40, height: 40)
                                    .padding(.leading)
                            }
                            Spacer()
                            
                            if selected != nil {
                                Button {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        selected = nil
                                    }
                                } label: {
                                    Text("Clear")
                                        .font(.footnote)
                                }
                                .buttonStyle(.bordered)
                                .buttonBorderShape(.capsule)
                                .tint(.pink)
                                .padding(.trailing)
                            }
                        }
                        
                        HStack {
                            Image(systemName: trait.image)
                                .resizable()
                                .matchedGeometryEffect(id: "\(trait).image", in: animation)
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 18)
                                .foregroundColor(trait.color)
                            Text(trait.title)
                                .matchedGeometryEffect(id: "\(trait).text", in: animation)
                                .font(.footnote)
                        }
                    }
                    .padding(.top)
                    
                    Spacer()
                }
                
                if selected != nil {
                    VStack {
                        Spacer()
                        
                        Button(action: back) {
                            Text("Done")
                                .font(.callout)
                        }
                        .buttonStyle(.bordered)
                        .padding(.bottom, 50)
                    }
                }
                
                HStack(spacing: 0) {
                    ForEach(0 ..< 5) { index in
                        Item(index: index, trait: trait, selected: selected == index) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                selected = index
                            }
                        }
                    }
                }
            }
        }
    }
}
