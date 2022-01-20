import SwiftUI

extension TrackOld.Content {
    struct Slide: View {
        @Binding var item: TrackOld.Status.Item
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color(.secondarySystemBackground))
                HStack {
                    if item.active {
                        VStack {
                            Slider(value: $item.value, in: 0 ... 100) {
                                Text(item.id.title)
                            } onEditingChanged: {
                                if !$0 {
                                    
                                }
                            }
                            .tint(item.id.color)
                            .padding(.leading, 8)
                            .padding(.trailing)
                            
                            HStack {
                                Text(item.id.low)
                                Spacer()
                                Text(item.id.high)
                            }
                            .foregroundColor(item.id.color)
                            .font(.caption2)
                        }
                    } else {
                        Spacer()
                    }
                    
                    VStack {
                        Button {
                            item.active.toggle()
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(item.active ? item.id.color : .init(.tertiaryLabel))
                                    .frame(width: 71, height: 71)
                                    .opacity(0.34)
                                Image(item.id.image)
                            }
                        }
                        
                        Text(item.id.title)
                            .font(.footnote)
                    }
                    .foregroundColor(item.active ? item.id.color : .init(.tertiaryLabel))
                }
                .padding()
            }
            .padding(.horizontal, 8)
        }
    }
}
