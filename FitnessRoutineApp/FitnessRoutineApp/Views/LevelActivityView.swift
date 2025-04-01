import SwiftUI

// MARK: - LevelActivityView
struct LevelActivityView: View {
    @StateObject private var viewModel = LevelActivityViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToNextView = false
    @State private var isNextButtonDisabled = false  // Estado para habilitar/deshabilitar el botón
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
            nextButton
            navigationLink
        }
        .background(backgroundColor.ignoresSafeArea())
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
            .padding(.top, 15)
            .padding(.bottom, 20)
            .foregroundColor(.black)
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
            .foregroundColor(.black)
    }
    
    var activitySlider: some View {
        Slider(value: $viewModel.sliderValue, in: 0...3, step: 1)
            .accentColor(.blue)
            .padding(.horizontal, 30)
    }
    
    var activityRangeLabels: some View {
        HStack {
            Text("Sedentary")
                .foregroundColor(.black)
            Spacer()
            Text("Very active")
                .foregroundColor(.black)
        }
        .padding(.horizontal, 30)
        .padding(.top, 5)
    }
    
    var nextButton: some View {
        Button(action: proceedToNext) {
            Text("Next")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 0)
        .disabled(isNextButtonDisabled)  // Deshabilitar el botón temporalmente
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
                    .foregroundColor(.blue)
                    .imageScale(.large)
            }
        }
    }
    
    var backgroundColor: Color {
        Color(red: 249/255, green: 249/255, blue: 253/255)
    }
    
    // Función para avanzar la barra de progreso y navegar a la siguiente pantalla
    func proceedToNext() {
        // Deshabilitar el botón por 2 segundos
        isNextButtonDisabled = true
        
        withAnimation(.easeInOut(duration: 0.5)) {
            progressViewModel.advanceProgress()
        }
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        // Reducir el retraso para una transición más rápida
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigateToNextView = true
        }
        
        // Habilitar el botón después de 2 segundos
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isNextButtonDisabled = false
        }
    }
    
    // Función para retroceder: disminuye el progreso y cierra la vista
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

