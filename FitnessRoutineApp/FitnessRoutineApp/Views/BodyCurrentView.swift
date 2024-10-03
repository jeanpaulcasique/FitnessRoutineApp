import SwiftUI

struct BodyCurrentView: View {
    @ObservedObject var viewModel = BodyCurrentViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel // Añadir el ProgressViewModel
    @State private var navigateToNextView = false // Controla la navegación

    var body: some View {
        VStack {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)

            // Título
            Text("What's your current body shape?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            // Opciones de formas corporales
            VStack(spacing: 20) {
                // Opción: Medium
                BodyOptionView(text: "Medium", imageName: "figure.walk", isSelected: viewModel.selectedBodyShape == .medium)
                    .onTapGesture {
                        viewModel.selectBodyShape(.medium)
                    }

                // Opción: Flabby
                BodyOptionView(text: "Flabby", imageName: "figure.sitting", isSelected: viewModel.selectedBodyShape == .flabby)
                    .onTapGesture {
                        viewModel.selectBodyShape(.flabby)
                    }

                // Opción: Skinny
                BodyOptionView(text: "Skinny", imageName: "figure.stand", isSelected: viewModel.selectedBodyShape == .skinny)
                    .onTapGesture {
                        viewModel.selectBodyShape(.skinny)
                    }

                // Opción: Muscular
                BodyOptionView(text: "Muscular", imageName: "figure.strength", isSelected: viewModel.selectedBodyShape == .muscular)
                    .onTapGesture {
                        viewModel.selectBodyShape(.muscular)
                    }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)

            Spacer() // Espaciador para empujar el botón hacia abajo

            // Botón para continuar, solo aparece si se selecciona una opción
            if viewModel.selectedBodyShape != nil {
                Button(action: {
                    progressViewModel.advanceProgress() // Avanza el progreso
                    navigateToNextView = true // Cambia el estado para navegar
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

                // Este NavigationLink se añade pero se mantiene oculto hasta que haya una vista real
                NavigationLink(destination: Text("Next View Placeholder"), isActive: $navigateToNextView) {
                    EmptyView()
                }
            }

        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(false) // Mostrar el botón "back" automático
    }
}

struct BodyOptionView: View {
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

// Preview para BodyCurrentView
struct BodyCurrentView_Previews: PreviewProvider {
    static var previews: some View {
        BodyCurrentView(viewModel: BodyCurrentViewModel(), progressViewModel: ProgressViewModel()) // Añadido ProgressViewModel
    }
}

