import SwiftUI
import Selene

struct AnalysisOld: View, Equatable {
    let observatory: Observatory
    @State private var traits = [Trait]()
    @State private var analysis = [Trait : [Moon.Phase : Level]]()
    @State private var phases = Moon.Phase.allCases.map { ($0, true) }
    @State private var filter = false
    @State private var empty = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                if empty {
                    Text("You will be able to analyse your data once you start tracking traits.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .padding(.vertical)
                } else {
                    ForEach(traits, id: \.self) { trait in
                        Section {
                            Item(value: analysis[trait] ?? [:],
                                 phases: phases.compactMap { $0.1 ? $0.0 : nil })
                                .equatable()
                        } header: {
                            Header(trait: trait)
                        }
                        .listRowBackground(Color.clear)
                    }
                }
            }
            .listStyle(.plain)
            .background(Color(.secondarySystemBackground))
            .navigationTitle("Analysis")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        filter = true
                    } label: {
                        Label("Filter", systemImage: "slider.horizontal.3")
                            .font(.footnote)
                            .symbolRenderingMode(.hierarchical)
                            .labelStyle(.titleAndIcon)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.bordered)
                    .tint(.accentColor)
                    .sheet(isPresented: $filter) {
                        SheetBasic(rootView: Filter(phases: $phases))
                            .equatable()
                            .edgesIgnoringSafeArea(.bottom)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24).weight(.light))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.primary)
                            .frame(width: 26, height: 40)
                            .padding(.leading)
                            .contentShape(Rectangle())
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .task {
            traits = await cloud.model.settings.traits.sorted()
            analysis = await cloud
                .analysis {
                    observatory.moon(for: $0).phase
                }
            
            empty = analysis.flatMap { $0.value.map { $0.value } }.isEmpty
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
