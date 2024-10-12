import SwiftUI
import UIKit // Importa UIKit para utilizar la vibración

struct GoalView: View {
    @ObservedObject var viewModel: GoalViewModel
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToBodyCurrent = false
    @State private var buttonScale: CGFloat = 1.0 // Variable para controlar la escala del botón
    @State private var showInfo: Bool = false // Controlar la visibilidad del texto informativo

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

            // Descripción con animación
            GoalInfoView(showInfo: $showInfo)
                .padding(.bottom, showInfo ? 20 : 10) // Añadir espacio adicional si se muestra la información
            
            // Opciones de objetivos
            goalOptions
            
            Spacer()

            // Navegación al siguiente paso
            NavigationLink(destination: BodyCurrentView(viewModel: BodyCurrentViewModel(), progressViewModel: progressViewModel), isActive: $navigateToBodyCurrent) {
                // Botón "Next", solo visible si se selecciona una opción
                if viewModel.selectedGoal != nil {
                    nextButton
                } else {
                    EmptyView() // Muestra una vista vacía si no hay selección
                }
            }
        }
        .padding(.top)
        .background(Color(red: 249/255, green: 249/255, blue: 253/255))
        .navigationBarTitle("", displayMode: .inline) // Mantener el título en modo inline
    }

    // Opciones de objetivos
    private var goalOptions: some View {
        VStack(spacing: 30) { // Aumentar el espaciado para mover las opciones hacia abajo
            GoalOptionImageView(imageName: "lossMen", isSelected: viewModel.selectedGoal == .loseWeight)
                .onTapGesture {
                    withAnimation {
                        viewModel.selectGoal(.loseWeight)
                        // Vibrar al seleccionar la opción
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                }

            GoalOptionImageView(imageName: "buildMen", isSelected: viewModel.selectedGoal == .buildMuscle)
                .onTapGesture {
                    withAnimation {
                        viewModel.selectGoal(.buildMuscle)
                        // Vibrar al seleccionar la opción
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                }

            GoalOptionImageView(imageName: "keepMen", isSelected: viewModel.selectedGoal == .keepFit)
                .onTapGesture {
                    withAnimation {
                        viewModel.selectGoal(.keepFit)
                        // Vibrar al seleccionar la opción
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }

    // Botón "Next"
    private var nextButton: some View {
        Button(action: {
            // Guardar el objetivo y avanzar en la barra de progreso
            viewModel.saveUserGoal()
            progressViewModel.advanceProgress()

            // Vibrar al presionar el botón
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()

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
                .scaleEffect(buttonScale) // Aplica la escala al botón
                .animation(.easeInOut(duration: 0.2), value: buttonScale) // Añade animación
        }
        .padding(.horizontal, 20)
        .simultaneousGesture( // Detectar el gesto de tocar para cambiar la escala
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    buttonScale = 0.95 // Reduce la escala al presionar
                }
                .onEnded { _ in
                    buttonScale = 1.0 // Restaura la escala al soltar
                }
        )
    }
}

// Vista de la opción de objetivo
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
                .animation(.easeInOut(duration: 0.2), value: isSelected)
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

// Vista personalizada para la sección informativa
struct GoalInfoView: View {
    @Binding var showInfo: Bool

    var body: some View {
        VStack { // Cambiar el ZStack a VStack para ajustar el espaciado dinámico
            // HStack para el icono de información y el texto
            HStack {
                Image(systemName: "info.circle")
                    .foregroundColor(.blue)
                    .font(.title)
                    .onTapGesture {
                        withAnimation {
                            showInfo.toggle()
                        }
                    }

                Text("Why we ask this?")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        withAnimation {
                            showInfo.toggle()
                        }
                    }

                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 0)

            // Reservar espacio para el texto informativo aunque no se muestre
            if showInfo {
                Text("Your goal shapes your workout. We'll tailor the best mix of cardio and strength training for you!")
                    .padding()
                  
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showInfo) // Controlar la animación
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView(viewModel: GoalViewModel(), progressViewModel: ProgressViewModel())
    }
}

