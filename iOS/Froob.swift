import SwiftUI

struct Froob: View {
    @State private var learn = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section {
                Image("Froob")
                    .frame(maxWidth: .greatestFiniteMagnitude)
                    .foregroundColor(.primary)
                Text("The Dark Side of the Moon")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .greatestFiniteMagnitude)
            }
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
            .listRowBackground(Color.clear)
            
            Section("Support Moon Health") {
                Text(.init(Copy.froob))
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundStyle(.secondary)
                    .font(.callout)
            }
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
            .listRowBackground(Color.clear)
            .allowsHitTesting(false)
            .textCase(.none)
            
            Section {
                Button {
                    learn = true
                } label: {
                    Text("Learn more")
                        .padding(.vertical, 4)
                        .frame(maxWidth: .greatestFiniteMagnitude)
                }
                .buttonStyle(.borderedProminent)
            }
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .listStyle(.insetGrouped)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $learn) {
            dismiss()
        } content: {
            NavigationView {
                Plus()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                learn = false
                            } label: {
                                Text("Close")
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                                    .padding(.leading)
                                    .frame(height: 34)
                                    .contentShape(Rectangle())
                            }
                        }
                    }
            }
            .navigationViewStyle(.stack)
        }
    }
}
