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
                .padding(.horizontal, 20)

            // Título
            Text("What's your current body shape?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
                // Limita el texto a una sola línea
                .minimumScaleFactor(0.5)

            // Opciones de formas corporales
            VStack(spacing: 20) {
                // Opción: Medium
                BodyOptionView(text: "", imageName: "mediumMen", isSelected: viewModel.selectedBodyShape == .medium)
                    .onTapGesture {
                        viewModel.selectBodyShape(.medium)
                    }

                // Opción: Flabby
                BodyOptionView(text: "", imageName: "flabbyMen", isSelected: viewModel.selectedBodyShape == .flabby)
                    .onTapGesture {
                        viewModel.selectBodyShape(.flabby)
                    }

                // Opción: Skinny
                BodyOptionView(text: "", imageName: "skinnyMen", isSelected: viewModel.selectedBodyShape == .skinny)
                    .onTapGesture {
                        viewModel.selectBodyShape(.skinny)
                    }

                // Opción: Muscular
                BodyOptionView(text: "", imageName: "muscularMen", isSelected: viewModel.selectedBodyShape == .muscular)
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
                    // Acción del botón
                    navigateToNextView = true // Navegar a la siguiente vista
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

                // Navegación hacia DesiredBodyView
                NavigationLink(destination: DesiredBodyView(progressViewModel: progressViewModel), isActive: $navigateToNextView) {
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
            Image(imageName) // Usar la imagen personalizada
                .resizable()
                .aspectRatio(contentMode: .fill) // Asegura que la imagen se expanda y llene todo el rectángulo
                .frame(width: 290, height: 70) // Ajusta las dimensiones del frame al tamaño del rectángulo
                
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
        BodyCurrentView(progressViewModel: ProgressViewModel()) // Añadido ProgressViewModel
    }
}

