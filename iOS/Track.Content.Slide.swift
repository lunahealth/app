import SwiftUI

extension Track.Content {
    struct Slide: View {
        @Binding var item: Track.Status.Item
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
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
                        VStack {
                            Slider(value: $item.value) {
                                Text(item.id.title)
                            } onEditingChanged: {
                                if !$0 {
                                    
                                }
                            }
                            .tint(item.id.color)
                            HStack {
                                Text(item.id.low)
                                Spacer()
                                Text(item.id.high)
                            }
                            .foregroundColor(item.id.color)
                            .font(.caption)
                        }
                        .padding(.horizontal)
                    } else {
                        Spacer()
                    }
                    
                    VStack {
                        ZStack {
                            Circle()
                                .fill(item.active ? item.id.color : .init(.tertiaryLabel))
                                .frame(width: 71, height: 71)
                                .opacity(0.5)
                            Image(item.id.image)
                        }
                        Text(item.id.title)
                            .font(.footnote)
                    }
                    .foregroundColor(item.active ? item.id.color : .init(.tertiaryLabel))
                }
                .padding()
            }
            .padding(.horizontal, 4)
        }
    }
}
