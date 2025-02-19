import SwiftUI
import UIKit

struct WorkoutLevelView: View {
    @StateObject private var viewModel = WorkoutLevelViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @Environment(\.presentationMode) var presentationMode // Para manejar la navegación

    @State private var navigateToNextScreen = false // Control para la navegación

    var body: some View {
        VStack(spacing: 20) {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)

            // Título principal
            Text("Choose your preferred workout level")
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding(.top, 40)
                .padding(.bottom, 20)

            // Lista de niveles
            levelOptionsList

            Spacer()

            // Botón "Next"
            nextButton

            // Navegación oculta
            NavigationLink(
                destination: NewScreenView(progressViewModel: progressViewModel),
                isActive: $navigateToNextScreen
            ) {
                EmptyView()
            }
        }
        .background(Color(red: 249 / 255, green: 249 / 255, blue: 253 / 255))
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true) // Ocultar el botón predeterminado
        .toolbar { backButton }
    }

    // MARK: - Subvistas
    private var levelOptionsList: some View {
        VStack {
            ForEach(viewModel.levels.indices, id: \.self) { index in
                levelOptionRow(for: index)
            }
        }
        .padding(.horizontal, 20)
    }

    private func levelOptionRow(for index: Int) -> some View {
        let isSelected = (index == viewModel.selectedIndex)

        return HStack {
            Image(systemName: viewModel.levels[index].1)
                .foregroundColor(isSelected ? .blue : .black)

            Text(viewModel.levels[index].0)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(isSelected ? .blue : .black)

            Spacer()

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color.blue.opacity(0.1) : Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
        )
        .onTapGesture {
            viewModel.selectLevel(at: index)
            triggerHapticFeedback()
        }
    }

    private var nextButton: some View {
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
        .padding(.bottom, 50)
    }

    private var backButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: goBack) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
                    .imageScale(.large)
            }
        }
    }

    // MARK: - Métodos
    private func proceedToNext() {
        withAnimation(.easeInOut(duration: 0.5)) {
            progressViewModel.advanceProgress()
        }
        triggerHapticFeedback()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            navigateToNextScreen = true
        }
    }

    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }

    private func goBack() {
        progressViewModel.decreaseProgress()
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Preview
struct WorkoutLevelView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLevelView(progressViewModel: ProgressViewModel())
    }
}

