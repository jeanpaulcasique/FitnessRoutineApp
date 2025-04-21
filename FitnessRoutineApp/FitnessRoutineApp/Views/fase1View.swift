import SwiftUI
import SDWebImageSwiftUI

struct Fase1View: View {
    @State private var navigateToNext = false
    let genderSelectionViewModel: GenderSelectionViewModel
    let progressViewModel: ProgressViewModel

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            AnimatedImage(name: "fase1.gif", isAnimating: .constant(true))
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .onAppear {
                    // Estimar duración del GIF si no tienes acceso directo a la duración
                    // Por ejemplo, si tu gif dura 4 segundos:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        navigateToNext = true
                    }
                }

            NavigationLink(
                destination: GenderSelectionView(
                    viewModel: genderSelectionViewModel,
                    progressViewModel: progressViewModel
                ),
                isActive: $navigateToNext
            ) {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

