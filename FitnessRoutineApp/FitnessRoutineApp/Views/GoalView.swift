import SwiftUI

struct GoalView: View {
    @ObservedObject var viewModel: GoalViewModel
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToBodyCurrent = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)

            // Título
            Text("What's your main goal?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            // Descripción
            HStack {
                Image("robotIcon")
                    .resizable()
                    .frame(width: 50, height: 50)

                VStack(alignment: .leading) {
                    Text("Your goal shapes your workout.")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.primary)

                    Text("We'll tailor the best mix of cardio and strength training for you!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .padding(.horizontal, 20)
            .padding(.top, 10)

            // Opciones de objetivos
            VStack(spacing: 20) {
                GoalOptionImageView(imageName: "lossMen", isSelected: viewModel.selectedGoal == .loseWeight)
                    .onTapGesture {
                        withAnimation {
                            viewModel.selectGoal(.loseWeight)
                        }
                    }

                GoalOptionImageView(imageName: "buildMen", isSelected: viewModel.selectedGoal == .buildMuscle)
                    .onTapGesture {
                        withAnimation {
                            viewModel.selectGoal(.buildMuscle)
                        }
                    }

                GoalOptionImageView(imageName: "keepMen", isSelected: viewModel.selectedGoal == .keepFit)
                    .onTapGesture {
                        withAnimation {
                            viewModel.selectGoal(.keepFit)
                        }
                    }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)

            Spacer()

            // Botón "Next", solo visible si se selecciona una opción
            if viewModel.selectedGoal != nil {
                Button(action: {
                    // Guardar el objetivo y avanzar en la barra de progreso
                    viewModel.saveUserGoal()
                    progressViewModel.advanceProgress()
                    // Activar la navegación
                    navigateToBodyCurrent = true
                }) {
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

                // Enlace de navegación
                NavigationLink(destination: BodyCurrentView(viewModel: BodyCurrentViewModel(), progressViewModel: progressViewModel), isActive: $navigateToBodyCurrent) {
                    EmptyView()
                }
            }
        }
        .padding(.top)
        .background(Color(red: 249/255, green: 249/255, blue: 253/255))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    // Disminuir el progreso y volver atrás
                    progressViewModel.decreaseProgress()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .font(.title)
                }
            }
        }
    }
}

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
                .animation(.easeInOut(duration: 0.3), value: isSelected)
                .scaleEffect(isSelected ? 1.05 : 1.0)

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
                    .offset(x: 160, y: -5)
                    .animation(.easeInOut(duration: 0.3))
            }
        }
    }
}

// Preview para GoalView
struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView(viewModel: GoalViewModel(), progressViewModel: ProgressViewModel())
    }
}

