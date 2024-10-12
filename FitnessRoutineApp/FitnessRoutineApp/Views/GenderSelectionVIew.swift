import SwiftUI
import UIKit // Asegúrate de importar UIKit para la vibración

struct GenderSelectionView: View {
    @ObservedObject var viewModel: GenderSelectionViewModel
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToGoal = false // Estado para controlar la navegación
    @State private var showInfo = false // Estado para mostrar/ocultar el texto de información

    var body: some View {
        ZStack {
            VStack {
                // Barra de progreso controlada por el ProgressViewModel
                ProgressBarView(progressViewModel: progressViewModel)
                    .padding(.top, 20)
                    .padding(.horizontal)

                // Título de la pantalla
                Text("What's your gender?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black) // Asegura que el texto sea negro
                    .padding(.top, 0)

                // Opciones de género con animación al seleccionar
                HStack(spacing: 37) {
                    GenderSelectionCard(gender: .male, isSelected: viewModel.selectedGender == .male) {
                        withAnimation {
                            viewModel.selectGender(.male)
                            // Añadir vibración al seleccionar un género
                            let generator = UIImpactFeedbackGenerator(style: .medium)
                            generator.impactOccurred()
                        }
                    }
                    .scaleEffect(viewModel.selectedGender == .male ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.1), value: viewModel.selectedGender)

                    GenderSelectionCard(gender: .female, isSelected: viewModel.selectedGender == .female) {
                        withAnimation {
                            viewModel.selectGender(.female)
                            // Añadir vibración al seleccionar un género
                            let generator = UIImpactFeedbackGenerator(style: .medium)
                            generator.impactOccurred()
                        }
                    }
                    .scaleEffect(viewModel.selectedGender == .female ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: viewModel.selectedGender)
                }
                .padding(.top, 150) // Añadir padding a la parte superior del HStack
                .padding() // Padding horizontal

                Spacer() // Añadimos un Spacer para empujar el botón hacia abajo

                // Botón de continuar, solo aparece si se seleccionó un género
                if viewModel.selectedGender != nil {
                    Button(action: {
                        // Avanzar el progreso solo al presionar el botón Next
                        withAnimation {
                            progressViewModel.advanceProgress()
                            navigateToGoal = true
                            // Añadir vibración al pulsar el botón Next
                            let generator = UIImpactFeedbackGenerator(style: .medium)
                            generator.impactOccurred()
                        }
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

                    NavigationLink(
                        destination: GoalView(viewModel: GoalViewModel(), progressViewModel: progressViewModel),
                        isActive: $navigateToGoal
                    ) {
                        EmptyView()
                    }
                    .padding(.bottom, 10) // Alinea el botón con otras pantallas colocando más espacio en la parte inferior
                }
            }
            .navigationBarTitle("", displayMode: .inline) // Mantener el título en modo inline
            .background(Color(red: 249/255, green: 249/255, blue: 253/255)) // Usar el color de fondo adecuado

            // Cuadro de información interactivo
            GenderInfoView(showInfo: $showInfo)
                .padding()
                .zIndex(1) // Asegura que esté por encima de otros elementos
        }
    }
}

// Vista de información encapsulada
struct GenderInfoView: View {
    @Binding var showInfo: Bool
        
    var body: some View {
        ZStack {
            
            // HStack para los íconos de información
            HStack {
                
                Image(systemName: "info.circle")
                    .foregroundColor(.blue)
                    .font(.title)
                    .padding(.top, -290)
                    .onTapGesture {
                        withAnimation {
                            showInfo.toggle()
                        }
                    }

                Text("Why we ask this?")
                    .font(.headline)
                    .padding(.top, -285)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        withAnimation {
                            showInfo.toggle()
                        }
                    }
                Spacer()
            }
            .padding(.horizontal)

            // Texto informativo que aparece como un overlay
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

                    .zIndex(1) // Asegura que esté por encima de otros elementos
                    .offset(y: 50) // Ajusta la posición vertical si es necesario
            }
        }
    }
}

// Vista de la tarjeta de selección de género
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
           
            .scaleEffect(isSelected ? 1.1 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: isSelected)
            .shadow(color: isSelected ? Color.blue.opacity(0.5) : Color.clear, radius: 10, x: 0, y: 5)

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
                    .offset(x: 60, y: -130)
                    .animation(.easeInOut(duration: 0.3))
            }
        }
    }
}

struct GenderSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = GenderSelectionViewModel()
        let progressViewModel = ProgressViewModel()
        GenderSelectionView(viewModel: viewModel, progressViewModel: progressViewModel)
    }
}

