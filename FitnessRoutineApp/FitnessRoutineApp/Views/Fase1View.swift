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
                .accessibilityIdentifier("fase1Gif")

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
        .onAppear {
            // Ajusta el tiempo al que dura exactamente tu gif
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.4) {
                navigateToNext = true
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Fase1View(
        genderSelectionViewModel: GenderSelectionViewModel(),
        progressViewModel: ProgressViewModel()
    )
}

