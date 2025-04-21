import SwiftUI

struct GoalView: View {
    @ObservedObject var viewModel: GoalViewModel
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToBodyCurrent = false
    @State private var showInfo: Bool = false
    @State private var isButtonDisabled = false
    @State private var isLoading = false

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.horizontal, 20)

            // Título
            Text("What's your main goal?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 20)

            // Información sobre los objetivos
            GoalInfoView(showInfo: $showInfo)
                .padding(.bottom, showInfo ? 20 : 10)

            // Opciones de objetivos
            goalOptions

            Spacer()

            // Botón "Next" visible solo si hay selección
            if viewModel.selectedGoal != nil {
                nextButton
            }

            // Navegación a la siguiente vista
            NavigationLink(
                destination: BodyCurrentView(viewModel: BodyCurrentViewModel(), progressViewModel: progressViewModel),
                isActive: $navigateToBodyCurrent
            ) {
                EmptyView()
            }
        }
        .padding(.top)
        .background(Color(red: 249/255, green: 249/255, blue: 253/255))
        .navigationBarTitle("", displayMode: .inline)
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
        .onAppear {
            viewModel.loadGoalFromUserDefaults()
            viewModel.loadGenderFromUserDefaults()
            print("GoalView onAppear - Género actual: \(viewModel.gender.rawValue)")
        }
    }

    private var goalOptions: some View {
        VStack(spacing: 30) {
            ForEach(Goal.allCases, id: \.self) { goal in
                GoalOptionImageView(imageName: viewModel.imageName(for: goal), isSelected: viewModel.selectedGoal == goal)
                    .onTapGesture {
                        withAnimation {
                            viewModel.selectGoal(goal)
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                    }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }

    private var nextButton: some View {
        NextButton(
            title: "Next",
            action: proceedToNext,
            isLoading: $isLoading,
            isDisabled: $isButtonDisabled
        )
    }

    private func proceedToNext() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        progressViewModel.advanceProgress()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigateToBodyCurrent = true
        }
    }

    private func goBack() {
        progressViewModel.decreaseProgress()
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Vista de opción de objetivo
struct GoalOptionImageView: View {
    let imageName: String
    let isSelected: Bool

    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 90)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
                )
                .shadow(color: isSelected ? Color.blue.opacity(0.5) : Color.clear, radius: 10, x: 0, y: 5)
                .scaleEffect(isSelected ? 1.05 : 1.0)

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
                    .offset(x: 170, y: -25)
                    
            }
        }
    }
}

// MARK: - Vista informativa
struct GoalInfoView: View {
    @Binding var showInfo: Bool

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "info.circle")
                    .foregroundColor(.blue)
                    .font(.title)
                    .onTapGesture { withAnimation { showInfo.toggle() } }
                Text("Why we ask this?")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .onTapGesture { withAnimation { showInfo.toggle() } }
                Spacer()
            }
            .padding(.horizontal)

            if showInfo {
                Text("Your goal shapes your workout. We'll tailor the best mix of cardio and strength training for you!")
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .transition(.opacity)
                    .padding(.horizontal, 20)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showInfo)
    }
}

// MARK: - Preview
struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GoalView(viewModel: GoalViewModel(), progressViewModel: ProgressViewModel())
        }
    }
}

