import SwiftUI
import UIKit

struct WorkoutLevelView: View {
    @StateObject private var viewModel = WorkoutLevelViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var navigateToNextScreen = false
    @State private var isNextButtonDisabled = false
    @State private var isNextButtonLoading = false

    var body: some View {
        VStack(spacing: 20) {
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)

            Text("Choose your preferred workout level")
                .font(.system(size: 29, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.yellow)
                .padding(.top, 10)
                .padding(.bottom, 15)
                .padding(.horizontal, 20)

            levelOptionsList

            Spacer()

            // Integración de NextButton
            NextButton(
                title: "Next",
                action: proceedToNext,
                isLoading: $isNextButtonLoading,
                isDisabled: $isNextButtonDisabled
            )
            .padding(.bottom, 15)

            NavigationLink(
                destination: NewScreenView(progressViewModel: progressViewModel),
                isActive: $navigateToNextScreen
            ) {
                EmptyView()
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
        .toolbar { backButton }
    }

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
                .foregroundColor(isSelected ? .yellow : .white)

            Text(viewModel.levels[index].0)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(isSelected ? .yellow : .white)

            Spacer()

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.yellow)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color.yellow.opacity(0.15) : Color.black)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.yellow : Color.white.opacity(0.2), lineWidth: 1)
        )
        .onTapGesture {
            viewModel.selectLevel(at: index)
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            // Habilitar Next tras selección
            isNextButtonDisabled = false
        }
    }

    private var backButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: goBack) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.yellow)
                    .imageScale(.large)
            }
        }
    }

    private func proceedToNext() {
        guard let selectedIndex = viewModel.selectedIndex else { return }

        // Guardar el nivel seleccionado
        let selectedLevel = viewModel.levels[selectedIndex].0
        UserDefaults.standard.set(selectedLevel, forKey: "selectedWorkoutLevel")

        // Avanzar progreso y navegar
        withAnimation(.easeInOut(duration: 0.5)) {
            progressViewModel.advanceProgress()
        }
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            navigateToNextScreen = true
        }
    }

    private func goBack() {
        progressViewModel.decreaseProgress()
        presentationMode.wrappedValue.dismiss()
    }
}


struct WorkoutLevelView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLevelView(progressViewModel: ProgressViewModel())
    }
}
