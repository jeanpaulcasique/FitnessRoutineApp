import SwiftUI

struct SettingsView: View {
    @AppStorage("isAppleHealthEnabled") private var isAppleHealthEnabled = false

    var body: some View {
        List {
            Section {
                NavigationLink(destination: ProfileView()) {
                    Label("Profile", systemImage: "person.crop.circle")
                        .foregroundColor(.white)
                }

                NavigationLink(destination: PlaceholderView(title: "Language")) {
                    Label("Language", systemImage: "globe")
                        .foregroundColor(.white)
                }

                Toggle(isOn: $isAppleHealthEnabled) {
                    Label("Apple Health", systemImage: "heart.fill")
                        .foregroundColor(.white)
                }
                .toggleStyle(SwitchToggleStyle(tint: .yellow))

                NavigationLink(destination: FAQView()) {
                    Label("FAQ", systemImage: "questionmark.circle")
                        .foregroundColor(.white)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .background(Color.black)
        .scrollContentBackground(.hidden)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .foregroundColor(.white)
    }
}

