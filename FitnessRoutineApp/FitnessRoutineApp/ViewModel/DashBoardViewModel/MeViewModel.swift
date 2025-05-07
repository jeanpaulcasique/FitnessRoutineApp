import SwiftUI

final class MeViewModel: ObservableObject {
    struct MeMenuItem: Identifiable {
        let id = UUID()
        let title: String
        let icon: String
        let color: Color
    }

    let accountSection: [MeMenuItem] = [
        MeMenuItem(title: "Subscription", icon: "crown.fill", color: .appYellow),
        MeMenuItem(title: "Coaches", icon: "person.2.fill", color: .appWhite),
        MeMenuItem(title: "Analytics", icon: "chart.bar.fill", color: .appWhite)
    ]

    let supportSection: [MeMenuItem] = [
        MeMenuItem(title: "Write to support", icon: "headphones", color: .appWhite),
        MeMenuItem(title: "Tell a friend", icon: "square.and.arrow.up", color: .appWhite),
        MeMenuItem(title: "Rate the app", icon: "star.fill", color: .appWhite),
        MeMenuItem(title: "Settings", icon: "gearshape.fill", color: .appWhite)
    ]

    let signInSection: [MeMenuItem] = [
        MeMenuItem(title: "Logout", icon: "arrow.right.square", color: .appYellow)
    ]
}


