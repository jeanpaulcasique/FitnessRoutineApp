import SwiftUI

// MARK: - TargetWeightView
struct TargetWeightView: View {
    @StateObject var viewModel: TargetWeightViewModel
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToHowOftenView = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)

            Text("What's your target weight?")
                .font(.system(size: 29, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                .foregroundColor(.black)

            Spacer(minLength: 70)

            HStack {
                Button(action: {
                    viewModel.toggleUnit(toKg: true)
                    saveWeightUnit(isKg: true)
                }) {
                    Text("kg")
                        .font(.system(size: 18, weight: .bold))
                        .frame(width: 60, height: 40)
                        .background(viewModel.isKgSelected ? Color.black : Color.gray.opacity(0.2))
                        .foregroundColor(viewModel.isKgSelected ? Color.white : Color.black)
                        .cornerRadius(20)
                }
                Button(action: {
                    viewModel.toggleUnit(toKg: false)
                    saveWeightUnit(isKg: false)
                }) {
                    Text("lb")
                        .font(.system(size: 18, weight: .bold))
                        .frame(width: 60, height: 40)
                        .background(viewModel.isKgSelected ? Color.gray.opacity(0.2) : Color.black)
                        .foregroundColor(viewModel.isKgSelected ? Color.black : Color.white)
                        .cornerRadius(20)
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 30)

            Text("\(Int(viewModel.weightInPreferredUnit)) \(viewModel.isKgSelected ? "kg" : "lb")")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.black)
                .padding(.bottom, 5)

            Slider(value: $viewModel.selectedWeightKg, in: 1...200, step: 0.5)

                .accentColor(.blue)
                .padding(.horizontal, 40)
                .onChange(of: viewModel.selectedWeightKg) { newValue in
                    viewModel.updateWeight(newWeight: newValue)
                    saveWeightToUserDefaults(weight: newValue)
                }

            Spacer()

            NavigationLink(
                destination: HowOftenView(progressViewModel: progressViewModel),
                isActive: $navigateToHowOftenView
            ) {
                EmptyView()
            }

            NextButton(
                title: "Next",
                action: proceedToNext,
                isLoading: $viewModel.isLoading,
                isDisabled: $viewModel.isNextButtonDisabled
            )
            .padding(.bottom, 0)
        }
        .onAppear {
            viewModel.updateHealthBenefitMessage()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: goBack) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                }
            }
        }
        .background(Color(red: 249/255, green: 249/255, blue: 253/255))
    }

    // MARK: - Acciones
    private func proceedToNext() {
        viewModel.isNextButtonDisabled = true
        viewModel.isLoading = true

        withAnimation(.easeInOut(duration: 0.5)) {
            progressViewModel.advanceProgress()
        }

        UIImpactFeedbackGenerator(style: .medium).impactOccurred()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            navigateToHowOftenView = true
        }
    }

    private func goBack() {
        progressViewModel.decreaseProgress()
        presentationMode.wrappedValue.dismiss()
    }

    // MARK: - Guardar en UserDefaults
    private func saveWeightToUserDefaults(weight: Double) {
        UserDefaults.standard.set(weight, forKey: "selectedTarget")
    }

    private func saveWeightUnit(isKg: Bool) {
        UserDefaults.standard.set(isKg, forKey: "isKgSelected")
    }
}

// MARK: - Preview
struct TargetWeightView_Previews: PreviewProvider {
    static var previews: some View {
        TargetWeightView(viewModel: TargetWeightViewModel(), progressViewModel: ProgressViewModel())
    }
}

