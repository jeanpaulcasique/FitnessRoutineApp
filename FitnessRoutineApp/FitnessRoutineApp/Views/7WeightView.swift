import SwiftUI

struct WeightView: View {
    @StateObject private var viewModel = WeightViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var isNavigatingToTargetWeightView = false
    @State private var isNextButtonDisabled = false
    @State private var isNextButtonLoading = false
    @State private var showBMIInfo = false // Nuevo estado para mostrar info
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
        .background(Color.black)
        .sheet(isPresented: $showBMIInfo) {
            BMIInfoView()
        }
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
            .foregroundColor(.yellow)
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
                    .foregroundColor(viewModel.isKgSelected ? .black : .yellow)
                    .padding()
                    .background(viewModel.isKgSelected ? Color.yellow : Color.clear)
                    .cornerRadius(15)
            }
            Button(action: {
                if viewModel.isKgSelected { viewModel.toggleUnit() }
            }) {
                Text("lb")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(!viewModel.isKgSelected ? .black : .yellow)
                    .padding()
                    .background(!viewModel.isKgSelected ? Color.yellow : Color.clear)
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
        .accentColor(.yellow)
        .padding(.horizontal, 30)
    }

    var selectedWeightDisplay: some View {
        Text(String(format: "%.1f", viewModel.weightInPreferredUnit) + (viewModel.isKgSelected ? " kg" : " lb"))
            .font(.system(size: 44, weight: .bold))
            .foregroundColor(.yellow)
            .padding(.bottom, 10)
    }

    // OPCIÓN 1: BMI con botón de información
    var bmiDisplay: some View {
        let bmi = viewModel.calculateBMI(heightInCm: userHeight)
        return HStack(spacing: 8) {
            Text(String(format: "BMI: %.1f", bmi))
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.yellow)
            
            Button(action: {
                showBMIInfo = true
            }) {
                Image(systemName: "info.circle")
                    .foregroundColor(.yellow.opacity(0.7))
                    .font(.system(size: 16))
            }
        }
        .padding(.bottom, 30)
    }
    
    // OPCIÓN 2: BMI con categoría (alternativa)
    var bmiDisplayWithCategory: some View {
        let bmi = viewModel.calculateBMI(heightInCm: userHeight)
        let category = getBMICategory(bmi: bmi)
        
        return VStack(spacing: 4) {
            HStack(spacing: 8) {
                Text(String(format: "BMI: %.1f", bmi))
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.yellow)
                
                Button(action: {
                    showBMIInfo = true
                }) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.yellow.opacity(0.7))
                        .font(.system(size: 16))
                }
            }
            
            Text(category)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.yellow.opacity(0.8))
        }
        .padding(.bottom, 30)
    }

    var nextButton: some View {
        VStack(spacing: 0) {
            NextButton(
                title: "Next",
                action: proceedToNext,
                isLoading: $isNextButtonLoading,
                isDisabled: $isNextButtonDisabled
            )
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
                    .foregroundColor(.yellow)
                    .imageScale(.large)
            }
        }
    }

    var backgroundColor: Color {
        Color(red: 249/255, green: 249/255, blue: 253/255)
    }
    
    // Función helper para categorías de BMI
    func getBMICategory(bmi: Double) -> String {
        switch bmi {
        case ..<18.5:
            return "Underweight"
        case 18.5..<25:
            return "Normal weight"
        case 25..<30:
            return "Overweight"
        default:
            return "Obese"
        }
    }

    func proceedToNext() {
        withAnimation(.easeInOut(duration: 0.5)) {
            progressViewModel.advanceProgress()
        }
        generateHapticFeedback()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            isNavigatingToTargetWeightView = true
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

// MARK: - BMI Info View
struct BMIInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Body Mass Index (BMI)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.yellow)
                    .padding(.bottom, 10)
                
                Text("BMI is a measure that uses your height and weight to work out if your weight is healthy.")
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.8))
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("BMI Categories:")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.yellow)
                    
                    BMICategoryRow(range: "Below 18.5", category: "Underweight", color: .cyan)
                    BMICategoryRow(range: "18.5 - 24.9", category: "Normal weight", color: .green)
                    BMICategoryRow(range: "25.0 - 29.9", category: "Overweight", color: .orange)
                    BMICategoryRow(range: "30.0 and above", category: "Obese", color: .red)
                }
                
                Text("Note: BMI is a useful screening tool, but it doesn't directly measure body fat. For a complete health assessment, consult with a healthcare professional.")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.top, 10)
                
                Spacer()
            }
            .padding(20)
            .background(Color.black)
            .navigationTitle("BMI Information")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.yellow))
        }
        .preferredColorScheme(.dark)
    }
}

struct BMICategoryRow: View {
    let range: String
    let category: String
    let color: Color
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
            
            Text(range)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 80, alignment: .leading)
            
            Text(category)
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.8))
            
            Spacer()
        }
    }
}

// MARK: - Preview
struct WeightView_Previews: PreviewProvider {
    static var previews: some View {
        WeightView(progressViewModel: ProgressViewModel(), userHeight: 170.0)
    }
}
