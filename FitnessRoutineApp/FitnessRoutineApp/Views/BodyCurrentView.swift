import SwiftUI
import UIKit

struct BodyCurrentView: View {
    @ObservedObject var viewModel = BodyCurrentViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var isButtonPressed = false // Para animación del botón
    @State private var navigateToNextView = false // Control de navegación
    @State private var isButtonDisabled = false // Estado para deshabilitar el botón "Next"
    @Environment(\.presentationMode) var presentationMode

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
                .foregroundColor(.black)
                .minimumScaleFactor(0.5)

            // Opciones de forma corporal
            VStack(spacing: 20) {
                ForEach(BodyCurrentViewModel.BodyShape.allCases, id: \.self) { shape in
                    BodyOptionView(imageName: shape.rawValue, isSelected: viewModel.selectedBodyShape == shape)
                        .onTapGesture {
                            withAnimation {
                                viewModel.selectBodyShape(shape) // Seleccionar opción
                                vibrate() // Vibrar al seleccionar
                            }
                        }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)

            Spacer()

            // Botón "Next", visible solo si hay una opción seleccionada
            if viewModel.selectedBodyShape != nil {
                Button(action: {
                    if !isButtonDisabled {
                        isButtonDisabled = true
                        proceedToNext()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            isButtonDisabled = false
                        }
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
                        .scaleEffect(isButtonPressed ? 0.95 : 1.0)
                        .animation(.easeInOut, value: isButtonPressed)
                }
                .padding(.horizontal, 20)
                .disabled(isButtonDisabled)
            }

            // Navegación a DesiredBodyView
            NavigationLink(destination: DesiredBodyView(viewModel: DesiredBodyViewModel(), progressViewModel: progressViewModel),
                           isActive: $navigateToNextView) {
                EmptyView()
            }
            .hidden()
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: goBack) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                }
            }
        }
        .background(Color(red: 249/255, green: 249/255, blue: 253/255))
    }

    // Función para avanzar a la siguiente pantalla
    private func proceedToNext() {
        vibrate()
        isButtonPressed = true
        progressViewModel.advanceProgress() // Aumentar progreso
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            navigateToNextView = true
        }
    }

    // Función para retroceder
    private func goBack() {
        progressViewModel.decreaseProgress() // Reducir progreso al retroceder
        presentationMode.wrappedValue.dismiss()
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

// Vista Previa
struct BodyCurrentView_Previews: PreviewProvider {
    static var previews: some View {
        BodyCurrentView(progressViewModel: ProgressViewModel())
    }
}

