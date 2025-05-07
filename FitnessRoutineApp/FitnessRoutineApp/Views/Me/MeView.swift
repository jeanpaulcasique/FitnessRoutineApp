import SwiftUI

struct MeView: View {
    @StateObject private var viewModel = MeViewModel()
    @EnvironmentObject var sessionManager: UserSessionManager

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Account").foregroundColor(.appWhite)) {
                    ForEach(viewModel.accountSection) { item in
                        navLink(item)
                    }
                }

                Section {
                    ForEach(viewModel.supportSection) { item in
                        navLink(item)
                    }
                }

                Section {
                    ForEach(viewModel.signInSection) { item in
                        if item.title == "Logout" {
                            Button(action: {
                                sessionManager.logout()
                            }) {
                                Label(item.title, systemImage: item.icon)
                                    .foregroundColor(item.color)
                            }
                        } else {
                            navLink(item)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .background(Color.appBlack)
            .scrollContentBackground(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.appWhite)
        }
        .accentColor(.appYellow)
    }

    private func navLink(_ item: MeViewModel.MeMenuItem) -> some View {
        NavigationLink(destination: destination(for: item.title)) {
            Label(item.title, systemImage: item.icon)
                .foregroundColor(item.color)
        }
    }

    @ViewBuilder
    private func destination(for title: String) -> some View {
        switch title {
        case "Settings":
            SettingsView()
        default:
            PlaceholderView(title: title)
        }
    }
}

// MARK: - PlaceholderView
struct PlaceholderView: View {
    let title: String

    var body: some View {
        ZStack {
            Color.appBlack.ignoresSafeArea()
            Text(title)
                .font(.title)
                .foregroundColor(.appYellow)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
            .environmentObject(UserSessionManager()) // Asegúrate de inyectar el sessionManager
            .preferredColorScheme(.dark)
    }
}

