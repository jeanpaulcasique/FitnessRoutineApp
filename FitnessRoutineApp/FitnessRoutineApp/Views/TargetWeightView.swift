import SwiftUI

// MARK: - TargetWeightView
struct TargetWeightView: View {
    @StateObject var viewModel: TargetWeightViewModel  // Cambiado a @StateObject para que persista
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
            
            Slider(value: $viewModel.selectedWeightKg, in: 60...90, step: 0.5)
                .accentColor(.blue)
                .padding(.horizontal, 40)
                .onChange(of: viewModel.selectedWeightKg) { newValue in
                    viewModel.updateWeight(newWeight: newValue)
                }
            
            Spacer()
            
            NavigationLink(
                destination: HowOftenView(progressViewModel: progressViewModel),
                isActive: $navigateToHowOftenView
            ) {
                EmptyView()
            }
            
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
                    .cornerRadius(12)
                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 5)
            }
            .padding(.horizontal, 20)
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
        withAnimation(.easeInOut(duration: 0.5)) {
            progressViewModel.advanceProgress()
        }
        
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigateToHowOftenView = true
        }
    }
    
    private func goBack() {
        progressViewModel.decreaseProgress()
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Preview
struct TargetWeightView_Previews: PreviewProvider {
    static var previews: some View {
        TargetWeightView(viewModel: TargetWeightViewModel(), progressViewModel: ProgressViewModel())
    }
}

