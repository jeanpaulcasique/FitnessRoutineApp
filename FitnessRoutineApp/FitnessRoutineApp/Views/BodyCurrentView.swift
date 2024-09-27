import SwiftUI

struct BodyCurrentView: View {
    @ObservedObject var viewModel = BodyCurrentViewModel()
    @Environment(\.presentationMode) var presentationMode // Añadir para controlar la navegación

    var body: some View {
        VStack {
            // Barra de progreso
            HStack {
                Spacer()
                Rectangle()
                    .frame(width: 75, height: 3)
                    .foregroundColor(.blue)
                Rectangle()
                    .frame(width: 25, height: 3)
                    .foregroundColor(.gray.opacity(0.3))
                Spacer()
            }
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
                Spacer(minLength: 50) // Espacio adicional para bajar más el botón
                Button(action: {
                    // Aquí puedes guardar la información del usuario o navegar a la siguiente pantalla
                }) {
                    Text("Continue")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }

            Spacer() // Otro espaciador para más separación en la parte inferior
        }
        .padding(.top)
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
        BodyCurrentView()
    }
}

