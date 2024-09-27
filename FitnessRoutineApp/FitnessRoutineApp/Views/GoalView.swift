import SwiftUI

struct GoalView: View {
    @ObservedObject var viewModel = GoalViewModel()
    @State private var navigateToBodyCurrent = false // Controla la navegación

    var body: some View {
        VStack {
            // Barra de progreso
            HStack {
                Spacer()
                Rectangle()
                    .frame(width: 50, height: 3)
                    .foregroundColor(.blue)
                Rectangle()
                    .frame(width: 50, height: 3)
                    .foregroundColor(.gray.opacity(0.3))
                Spacer()
            }
            .padding(.top, 20)

            // Título
            Text("What's your main goal?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            // Cuadro de texto con el estilo solicitado
            HStack {
                Image("robotIcon") // Reemplaza con tu imagen de robot
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
                // Opción: Lose Weight
                GoalOptionView(text: "Lose Weight", imageName: "figure.walk", isSelected: viewModel.selectedGoal == .loseWeight)
                    .onTapGesture {
                        viewModel.selectGoal(.loseWeight)
                    }

                // Opción: Build Muscle
                GoalOptionView(text: "Build Muscle", imageName: "figure.strength", isSelected: viewModel.selectedGoal == .buildMuscle)
                    .onTapGesture {
                        viewModel.selectGoal(.buildMuscle)
                    }

                // Opción: Keep Fit
                GoalOptionView(text: "Keep Fit", imageName: "figure.run", isSelected: viewModel.selectedGoal == .keepFit)
                    .onTapGesture {
                        viewModel.selectGoal(.keepFit)
                    }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)

            Spacer() // Empuja el botón hacia abajo

            // Botón para continuar
            if viewModel.selectedGoal != nil {
                NavigationLink(destination: BodyCurrentView(), isActive: $navigateToBodyCurrent) {
                    Button(action: {
                        viewModel.saveUserGoal() // Guarda la información del usuario
                        navigateToBodyCurrent = true // Navegar a BodyCurrentView
                    }) {
                        Text("Continue")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20) // Espacio en la parte inferior
            }
        }
        .padding(.top)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(false) // Mostrar el botón "back" automático
    }
}

struct GoalOptionView: View {
    let text: String
    let imageName: String
    let isSelected: Bool

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 60, height: 60)
                .aspectRatio(contentMode: .fit)
                .padding(.trailing, 10)

            Text(text)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)

            Spacer()

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
                    .font(.title)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2) // Borde azul solo si está seleccionado
        )
        .shadow(color: isSelected ? Color.blue.opacity(0.5) : Color.black.opacity(0.1), radius: 10, x: 0, y: 5) // Sombra azul solo si está seleccionado
        .scaleEffect(isSelected ? 1.05 : 1.0) // Efecto de escala al seleccionar
        .animation(.easeInOut, value: isSelected) // Animación suave
    }
}

// Preview para GoalView
struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}

