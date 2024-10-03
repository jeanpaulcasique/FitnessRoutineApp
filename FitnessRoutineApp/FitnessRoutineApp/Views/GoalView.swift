import SwiftUI

struct GoalView: View {
    @ObservedObject var viewModel: GoalViewModel // Cambia esto a una variable pasada
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToBodyCurrent = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)

            // Título
            Text("What's your main goal?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            // Cuadro de texto
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
                        viewModel.selectGoal(.loseWeight)
                    }

                GoalOptionImageView(imageName: "buildMen", isSelected: viewModel.selectedGoal == .buildMuscle)
                    .onTapGesture {
                        viewModel.selectGoal(.buildMuscle)
                    }

                GoalOptionImageView(imageName: "keepMen", isSelected: viewModel.selectedGoal == .keepFit)
                    .onTapGesture {
                        viewModel.selectGoal(.keepFit)
                    }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)

            Spacer()

            // Botón para continuar
            if let _ = viewModel.selectedGoal {
                Button(action: {
                    viewModel.saveUserGoal() // Guarda la información del usuario
                    progressViewModel.advanceProgress() // Actualiza el progreso al avanzar
                    navigateToBodyCurrent = true // Navegar a BodyCurrentView
                }) {
                    Text("Continue")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                .background(
                    NavigationLink(destination: BodyCurrentView(viewModel: BodyCurrentViewModel(), progressViewModel: progressViewModel), isActive: $navigateToBodyCurrent) {
                        EmptyView()
                    }
                )
            }
        }
        .padding(.top)
        .background(Color(red: 249/255, green: 249/255, blue: 253/255))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    progressViewModel.decreaseProgress() // Retroceder el progreso
                    self.presentationMode.wrappedValue.dismiss() // Retroceder a la vista anterior
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .font(.title)
                }
            }
        }
        .onAppear {
            // No avanzar automáticamente
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
                .frame(height: 100)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
                        .animation(.easeInOut)
                )
                .shadow(color: isSelected ? Color.blue.opacity(0.5) : Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                .scaleEffect(isSelected ? 1.05 : 1.0)
                .animation(.easeInOut, value: isSelected)

            if isSelected {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                    )
                    .offset(x: 160, y: 0)
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

