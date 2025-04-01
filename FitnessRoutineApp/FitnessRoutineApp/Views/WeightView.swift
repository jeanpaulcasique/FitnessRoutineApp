import SwiftUI

// MARK: - WeightView
struct WeightView: View {
    @StateObject private var viewModel = WeightViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var isNavigatingToTargetWeightView = false
    @State private var isNextButtonDisabled = false
    var userHeight: Double

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            progressBar
            title
            Spacer(minLength: 100)
            unitSelector
            weightSlider
            selectedWeightDisplay
            bmiDisplay
            Spacer(minLength: 200)
            nextButton
        }
        .onAppear {
            viewModel.updateWeight(newWeight: viewModel.selectedWeightKg)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar { backButton }
        .background(backgroundColor)
    }
}

// MARK: - Subviews & Helpers
private extension WeightView {
    var progressBar: some View {
        ProgressBarView(progressViewModel: progressViewModel)
            .padding(.top, 20)
            .padding(.horizontal, 20)
    }
    
    var title: some View {
        Text("What's your current weight?")
            .font(.system(size: 27, weight: .bold))
            .foregroundColor(.black)
            .padding(.top, 40)
            .padding(.bottom, 10)
            .padding(.horizontal, 20)
    }
    
    var unitSelector: some View {
        HStack {
            Button(action: {
                if !viewModel.isKgSelected { viewModel.toggleUnit() }
            }) {
                Text("kg")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(viewModel.isKgSelected ? .white : .black)
                    .padding()
                    .background(viewModel.isKgSelected ? Color.black : Color.clear)
                    .cornerRadius(15)
            }
            Button(action: {
                if viewModel.isKgSelected { viewModel.toggleUnit() }
            }) {
                Text("lb")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(!viewModel.isKgSelected ? .white : .black)
                    .padding()
                    .background(!viewModel.isKgSelected ? Color.black : Color.clear)
                    .cornerRadius(15)
            }
        }
        .padding(.bottom, 30)
        .padding(.horizontal, 40)
    }
    
    var weightSlider: some View {
        let minWeightKg: Double = 0
        let maxWeightKg: Double = 200
        let minWeightLb: Double = 0
        let maxWeightLb: Double = 440.92
        
        return Slider(value: Binding(
            get: {
                viewModel.isKgSelected ? viewModel.selectedWeightKg : viewModel.selectedWeightLb
            },
            set: { newValue in
                if viewModel.isKgSelected {
                    viewModel.updateWeight(newWeight: newValue)
                } else {
                    viewModel.updateWeight(newWeight: newValue / 2.20462)
                }
            }
        ), in: viewModel.isKgSelected ? minWeightKg...maxWeightKg : minWeightLb...maxWeightLb, step: 0.1)
        .accentColor(.blue)
        .padding(.horizontal, 30)
    }
    
    var selectedWeightDisplay: some View {
        Text(String(format: "%.1f", viewModel.weightInPreferredUnit) + (viewModel.isKgSelected ? " kg" : " lb"))
            .font(.system(size: 44, weight: .bold))
            .foregroundColor(.black)
            .padding(.bottom, 10)
    }
    
    var bmiDisplay: some View {
        let bmi = viewModel.calculateBMI(heightInCm: userHeight)
        return Text(String(format: "BMI: %.1f", bmi))
            .font(.system(size: 20, weight: .medium))
            .foregroundColor(.black)
            .padding(.bottom, 30)
    }
    
    var nextButton: some View {
        VStack(spacing: 0) {
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
            .disabled(isNextButtonDisabled)
            .simultaneousGesture(TapGesture().onEnded {
                generateHapticFeedback()
            })
            
            NavigationLink(
                destination: TargetWeightView(viewModel: TargetWeightViewModel(), progressViewModel: progressViewModel),
                isActive: $isNavigatingToTargetWeightView
            ) {
                EmptyView()
            }
            .hidden()
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
    
    func proceedToNext() {
        isNextButtonDisabled = true
        withAnimation(.easeInOut(duration: 0.5)) {
            progressViewModel.advanceProgress()
        }
        generateHapticFeedback()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.isNavigatingToTargetWeightView = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isNextButtonDisabled = false
        }
    }
    
    func goBack() {
        progressViewModel.decreaseProgress()
        presentationMode.wrappedValue.dismiss()
    }
    
    func generateHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

// MARK: - Preview
struct WeightView_Previews: PreviewProvider {
    static var previews: some View {
        WeightView(progressViewModel: ProgressViewModel(), userHeight: 170.0)
    }
}

