import SwiftUI
import UIKit

// MARK: - GenderSelectionView
struct GenderSelectionView: View {
    @ObservedObject var viewModel: GenderSelectionViewModel
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToGoal = false
    @State private var showInfo = false
    @State private var progressUpdating = false // Nuevo estado para manejar la animación
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack {
                // Barra de progreso con animación condicional
                ProgressBarView(progressViewModel: progressViewModel)
                    .padding(.top, 20)
                    .padding(.horizontal)
                    .opacity(progressUpdating ? 0.5 : 1.0) // Reducir opacidad durante la actualización

                Text("What's your gender?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 0)
                
                HStack(spacing: 37) {
                    GenderSelectionCard(gender: .male, isSelected: viewModel.selectedGender == .male) {
                        viewModel.selectGender(.male)
                        generateHapticFeedback()
                    }
                    GenderSelectionCard(gender: .female, isSelected: viewModel.selectedGender == .female) {
                        viewModel.selectGender(.female)
                        generateHapticFeedback()
                    }
                }
                .padding(.top, 150)
                .padding()
                
                Spacer()
                
                if viewModel.selectedGender != nil {
                    Button(action: proceedToNext) {
                        Text("Next")
                            .font(.headline)
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
                    
                    NavigationLink(
                        destination: GoalView(viewModel: GoalViewModel(), progressViewModel: progressViewModel),
                        isActive: $navigateToGoal
                    ) {
                        EmptyView()
                    }
                    .padding(.bottom, 10)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .background(Color(red: 249/255, green: 249/255, blue: 253/255))
            
            GenderInfoView(showInfo: $showInfo)
                .padding()
                .zIndex(1)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: goBack) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                }
            }
        }
    }
    
    private func proceedToNext() {
        // Actualizar la barra de progreso con animación antes de continuar
        withAnimation(.easeInOut(duration: 0.5)) {
            progressUpdating = true
        }
        
        // Avanzar en la barra de progreso
        progressViewModel.advanceProgress()
        
        // Generar feedback háptico
        generateHapticFeedback()

        // Esperar un poco antes de navegar a la siguiente vista
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigateToGoal = true
            withAnimation {
                progressUpdating = false
            }
        }
    }
    
    private func goBack() {
        progressViewModel.decreaseProgress()
        presentationMode.wrappedValue.dismiss()
    }
    
    private func generateHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

// MARK: - GenderInfoView
struct GenderInfoView: View {
    @Binding var showInfo: Bool
    
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "info.circle")
                    .foregroundColor(.blue)
                    .font(.title)
                    .padding(.top, -290)
                    .onTapGesture { withAnimation { showInfo.toggle() } }
                
                Text("Why we ask this?")
                    .font(.headline)
                    .padding(.top, -285)
                    .foregroundColor(.blue)
                    .onTapGesture { withAnimation { showInfo.toggle() } }
                Spacer()
            }
            .padding(.horizontal)
            
            if showInfo {
                Text("This will help us tailor your workout to match your metabolic rate perfectly.")
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .transition(.opacity)
                    .padding(.horizontal)
                    .padding(.top, -290)
                    .zIndex(1)
                    .offset(y: 50)
            }
        }
    }
}

// MARK: - GenderSelectionCard
struct GenderSelectionCard: View {
    let gender: Gender
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Button(action: action) {
                Image(gender == .male ? "male" : "female")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 275)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
                    )
            }
            .scaleEffect(isSelected ? 1.05 : 1.0)
            .shadow(color: isSelected ? Color.blue.opacity(0.5) : Color.clear, radius: 10, x: 0, y: 5)
            
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
                    .offset(x: 55, y: -120)
            }
        }
    }
}

// MARK: - Preview
struct GenderSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectionView(viewModel: GenderSelectionViewModel(), progressViewModel: ProgressViewModel())
    }
}

