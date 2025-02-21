import SwiftUI

struct GoalView: View {
    @ObservedObject var viewModel: GoalViewModel
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToBodyCurrent = false
    @State private var buttonScale: CGFloat = 1.0
    @State private var showInfo: Bool = false
    @State private var progressUpdating: Bool = false // Nuevo estado para manejar la animación

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // Barra de progreso (ahora con animación condicional)
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.horizontal, 20)
                .opacity(progressUpdating ? 0.5 : 1.0) // Reduce opacidad durante la actualización

            // Título
            Text("What's your main goal?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 20)

            // Información adicional
            GoalInfoView(showInfo: $showInfo)
                .padding(.bottom, showInfo ? 20 : 10)

            // Opciones de objetivos
            goalOptions

            Spacer()

            // Botón "Next"
            if viewModel.selectedGoal != nil {
                nextButton
            }

            // Navegación a BodyCurrentView
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
            // Cargar el objetivo guardado desde UserDefaults cuando la vista aparece
            viewModel.loadGoalFromUserDefaults()
        }
    }

    // MARK: - Opciones de objetivos
    private var goalOptions: some View {
        VStack(spacing: 30) {
            ForEach(Goal.allCases, id: \.self) { goal in
                GoalOptionImageView(imageName: goal.imageName, isSelected: viewModel.selectedGoal == goal)
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

    // MARK: - Botón "Next"
    private var nextButton: some View {
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
                .scaleEffect(buttonScale)
                .animation(.easeInOut(duration: 0.2), value: buttonScale)
        }
        .padding(.horizontal, 20)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in buttonScale = 0.95 }
                .onEnded { _ in buttonScale = 1.0 }
        )
    }

    // MARK: - Acciones
    private func proceedToNext() {
        // Actualizar la barra de progreso con animación antes de continuar
        withAnimation(.easeInOut(duration: 0.5)) {
            progressUpdating = true
        }

        // Llamar a la función para avanzar en la barra
        progressViewModel.advanceProgress()

        // Haptic feedback
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()

        // Esperar un poco antes de navegar a la siguiente vista para hacer la transición suave
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigateToBodyCurrent = true
            withAnimation {
                progressUpdating = false
            }
        }
    }

    private func goBack() {
        progressViewModel.decreaseProgress()
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Extensión para imágenes de objetivos
private extension Goal {
    var imageName: String {
        switch self {
        case .loseWeight: return "lossMen"
        case .buildMuscle: return "buildMen"
        case .keepFit: return "keepMen"
        }
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
                    .animation(.easeInOut(duration: 0.3))
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
        GoalView(viewModel: GoalViewModel(), progressViewModel: ProgressViewModel())
    }
}

