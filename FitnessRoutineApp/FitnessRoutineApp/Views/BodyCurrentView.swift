import SwiftUI
import UIKit 
struct BodyCurrentView: View {
    @ObservedObject var viewModel = BodyCurrentViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var isButtonPressed = false // Estado para la animación del botón
    @Environment(\.presentationMode) var presentationMode // Para manejar la navegación

    var body: some View {
        VStack {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)

            // Título de la vista
            Text("What's your current body shape?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
                .foregroundColor(.black)
                .minimumScaleFactor(0.5)

            // Opciones de forma corporal
            VStack(spacing: 20) {
                ForEach(BodyCurrentViewModel.BodyShape.allCases, id: \.self) { shape in
                    BodyOptionView(imageName: shape.rawValue, isSelected: viewModel.selectedBodyShape == shape)
                        .onTapGesture {
                            withAnimation {
                                viewModel.selectBodyShape(shape) // Seleccionar la opción
                                vibrate() // Vibrar al seleccionar una opción
                            }
                        }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)

            Spacer()

            // Botón "Next", visible solo si hay una opción seleccionada
            if let _ = viewModel.selectedBodyShape { // Solo mostrar el botón si se ha seleccionado una opción
                Button(action: {
                    vibrate() // Vibrar al pulsar el botón
                    progressViewModel.advanceProgress()
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
                        .scaleEffect(isButtonPressed ? 0.95 : 1.0) // Animación de escala
                        .animation(.easeInOut, value: isButtonPressed) // Añadir animación
                }
                .simultaneousGesture(DragGesture(minimumDistance: 0)
                    .onChanged { _ in isButtonPressed = true } // Cambia el estado al presionar
                    .onEnded { _ in
                        isButtonPressed = false // Restaura el estado al soltar
                    }
                )
                .padding(.horizontal, 20)

                // Navegación a DesiredBodyView
                NavigationLink(destination: DesiredBodyView(viewModel: DesiredBodyViewModel(), progressViewModel: progressViewModel), isActive: .constant(isButtonPressed && viewModel.selectedBodyShape != nil)) {
                    EmptyView()
                }
                .hidden() // Ocultar el NavigationLink
            }

        }
        .navigationBarTitle("", displayMode: .inline)
        .onDisappear {
    
        }
        .background(Color(red: 249/255, green: 249/255, blue: 253/255)) // Fondo claro
    }

    // Función de vibración
    private func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

// Vista de la opción de cuerpo
struct BodyOptionView: View {
    let imageName: String
    let isSelected: Bool

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 290, height: 70)

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
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
        )
        .shadow(color: isSelected ? Color.blue.opacity(0.5) : Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.easeInOut, value: isSelected)
    }
}

// Preview para BodyCurrentView
struct BodyCurrentView_Previews: PreviewProvider {
    static var previews: some View {
        BodyCurrentView(progressViewModel: ProgressViewModel())
    }
}

