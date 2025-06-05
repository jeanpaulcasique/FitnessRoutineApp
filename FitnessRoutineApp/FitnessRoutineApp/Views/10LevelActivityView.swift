import SwiftUI

// MARK: - LevelActivityView
struct LevelActivityView: View {
    @StateObject private var viewModel = LevelActivityViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToNextView = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            progressBar
            titleView
            representativeImage
            activityDescriptionView
            activitySlider
            activityRangeLabels
            Spacer()
            
            // NextButton personalizado
            NextButton(
                title: "Next",
                action: proceedToNext,
                isLoading: $viewModel.isLoading,
                isDisabled: $viewModel.isNextButtonDisabled
            )
            .padding(.bottom, 0)

            navigationLink
        }
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar { backButton }
    }
}

// MARK: - Subviews & Helpers
private extension LevelActivityView {
    var progressBar: some View {
        ProgressBarView(progressViewModel: progressViewModel)
            .padding(.top, 20)
            .padding(.horizontal, 20)
    }

    var titleView: some View {
        Text("What's your activity level?")
            .font(.system(size: 29, weight: .bold))
            .multilineTextAlignment(.center)
            .padding(.vertical, 20)
            .foregroundColor(.yellow)
            .padding(.horizontal, 20)
    }

    var representativeImage: some View {
        Image(viewModel.currentImageName)
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
            .padding(.bottom, 10)
    }

    var activityDescriptionView: some View {
        Text(viewModel.activityDescription)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .foregroundColor(.white)
    }

    var activitySlider: some View {
        Slider(value: $viewModel.sliderValue, in: 0...3, step: 1)
            .accentColor(.yellow)
            .padding(.horizontal, 30)
            .onChange(of: viewModel.sliderValue) { _ in
                viewModel.updateActivityLevel()
            }
    }

    var activityRangeLabels: some View {
        HStack {
            Text("Sedentary")
            Spacer()
            Text("Very active")
        }
        .font(.system(size: 18))
        .foregroundColor(.yellow)
        .padding(.horizontal, 30)
        .padding(.top, 5)
    }

    var navigationLink: some View {
        NavigationLink(
            destination: WorkoutLevelView(progressViewModel: progressViewModel),
            isActive: $navigateToNextView
        ) {
            EmptyView()
        }
    }

    var backButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: goBack) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.yellow)
                    .imageScale(.large)
            }
        }
    }

    var backgroundColor: Color {
        Color(red: 249/255, green: 249/255, blue: 253/255)
    }

    func proceedToNext() {
        // Deshabilita + muestra loading
        viewModel.disableNextButtonTemporarily()

        withAnimation(.easeInOut(duration: 0.5)) {
            progressViewModel.advanceProgress()
        }
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()

        // Navega tras un pequeño delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            navigateToNextView = true
        }
    }

    func goBack() {
        progressViewModel.decreaseProgress()
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Preview
struct LevelActivityView_Previews: PreviewProvider {
    static var previews: some View {
        LevelActivityView(progressViewModel: ProgressViewModel())
    }
}

