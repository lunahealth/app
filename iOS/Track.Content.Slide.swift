import SwiftUI

extension Track.Content {
    struct Slide: View {
        @Binding var item: Track.Status.Item
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.secondarySystemBackground))
                HStack {
                    Button {
                        item.active.toggle()
                    } label: {
                        Image(systemName: item.active ? "checkmark.square" : "square")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .foregroundColor(.blue)
                            .contentShape(Rectangle())
                    }
                    .frame(width: 40)
                    
                    if item.active {
                        Slider(value: $item.value) {
                            Text(item.id.title)
                        } onEditingChanged: {
                            if !$0 {
                                
                            }
                        }
                        .padding(.horizontal)
                    } else {
                        Spacer()
                    }
                    
                    VStack {
                        Image(item.id.image)
                        Text(item.id.title)
                            .font(.footnote)
                    }
                    .foregroundColor(item.active ? item.id.color : .init(.tertiaryLabel))
                }
                .padding()
            }
            .padding(.horizontal)
        }
    }
}
