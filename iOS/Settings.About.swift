import SwiftUI
import Selene

extension Settings {
    struct About: View {
        var body: some View {
            List {
                Section {
                    HStack {
                        Spacer()
                        VStack {
                            Image("Logo")
                            Text(verbatim: "Moon Health")
                                .font(.body.weight(.medium))
                                .foregroundStyle(.primary)
                            Text(verbatim: Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "")
                                .font(.footnote.monospacedDigit().weight(.medium))
                                .foregroundStyle(.secondary)
                        }
                        .padding(.top, 70)
                        .padding(.bottom, 150)
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
                Section {
                    Link(destination: URL(string: "https://lunahealth.github.io/about")!) {
                        HStack {
                            Text("Moon Health")
                                .font(.callout)
                            Spacer()
                            Image(systemName: "link")
                                .font(.system(size: 20).weight(.light))
                        }
                    }
                    
                    Button {
                        UIApplication.shared.review()
                        Defaults.hasRated = true
                    } label: {
                        HStack {
                            Text("Rate on the App Store")
                                .font(.callout)
                            Spacer()
                            Image(systemName: "star")
                                .font(.system(size: 20).weight(.light))
                        }
                    }
                }
                
                Section {
                    HStack(spacing: 0) {
                        Spacer()
                        Text("From Berlin with ")
                        Image(systemName: "heart")
                            .font(.system(size: 18).weight(.light))
                        Spacer()
                    }
                }
                .font(.caption)
                .foregroundColor(.secondary)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .symbolRenderingMode(.multicolor)
            .listStyle(.insetGrouped)
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
