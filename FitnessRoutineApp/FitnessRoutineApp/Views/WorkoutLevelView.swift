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
            levelOptionsList()

            Spacer()

            // Botón para avanzar
            NavigationLink(destination: NewScreenView(progressViewModel: progressViewModel), isActive: $navigateToNextScreen) {
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
            .onTapGesture {
                triggerHapticFeedback()  // Vibración al presionar el botón Next
                navigateToNextScreen = true  // Navegar a la siguiente pantalla
            }
        }
        .background(Color(red: 249 / 255, green: 249 / 255, blue: 253 / 255))
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true) // Ocultar el botón predeterminado
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Regresa a la pantalla anterior
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue) // Azul
                        .imageScale(.large) // Tamaño de la flecha igual a las otras pantallas
                }
            }
        }
    }

    @ViewBuilder
    private func levelOptionsList() -> some View {
        ForEach(viewModel.levels.indices, id: \.self) { index in
            HStack {
                Image(systemName: viewModel.levels[index].1)
                    .foregroundColor(index == viewModel.selectedIndex ? .blue : .black)

                Text(viewModel.levels[index].0)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(index == viewModel.selectedIndex ? .blue : .black)

                Spacer()

                if index == viewModel.selectedIndex {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(index == viewModel.selectedIndex ? Color.blue.opacity(0.1) : Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(index == viewModel.selectedIndex ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
            )
            .onTapGesture {
                viewModel.selectLevel(at: index)
                triggerHapticFeedback()
            }
        }
        .padding(.horizontal, 20)
    }

    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

struct WorkoutLevelView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLevelView(progressViewModel: ProgressViewModel())
    }
}

