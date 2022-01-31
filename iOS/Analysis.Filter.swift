import SwiftUI
import Selene

extension Analysis {
    struct Filter: View {
        @Binding var phases: [(Moon.Phase, Bool)]
        @Environment(\.dismiss) private var dismiss
        private let moonImage = Image("MoonMini")
        private let shadowImage = Image("ShadowMini")
        
        var body: some View {
            NavigationView {
                List($phases, id: \.0) { item in
                    Toggle(isOn: item.1) {
                        HStack {
                            Canvas { context, _ in
                                context.draw(phase: item.wrappedValue.0,
                                             image: moonImage,
                                             shadow: shadowImage,
                                             radius: 7,
                                             center: .init(x: 8, y: 8))
                            }
                            .frame(width: 16, height: 16)
                            Text(item.wrappedValue.0.name)
                                .font(.footnote)
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .navigationTitle("Moon Phases")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Toggle all") {
                            if phases.contains(where: { $0.1 }) {
                                phases = phases
                                    .map {
                                        ($0.0, false)
                                    }
                            } else {
                                phases = phases
                                    .map {
                                        ($0.0, true)
                                    }
                            }
                        }
                        .buttonStyle(.bordered)
                        .font(.footnote)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 24).weight(.light))
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.secondary)
                                .frame(width: 26, height: 40)
                                .padding(.leading)
                                .contentShape(Rectangle())
                        }
                    }
                }
            }
            .navigationViewStyle(.stack)
        }
    }
}
