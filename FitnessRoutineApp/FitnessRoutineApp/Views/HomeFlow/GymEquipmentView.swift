import SwiftUI

struct GymEquipmentView: View {
    @StateObject private var viewModel = GymEquipmentViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel  // Asegúrate de pasar el ProgressViewModel aquí
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel) // Agregar la barra de progreso aquí
                .padding(.top, 20)
                .padding(.horizontal, 20)

            // Título
            Text("Do you have gym equipment?")
                .font(.system(size: 35, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            
            // Botón 1: Bodyweight
            GymEquipmentButton(imageName: "gymE1", index: 0, viewModel: viewModel)
            
            // Botón 2: Gym Equipment
            GymEquipmentButton(imageName: "gymE2", index: 1, viewModel: viewModel)
            
            Spacer()
            
            // Botón "Next"
            Button(action: {
                // Acción en función de la opción seleccionada
                triggerHapticFeedback() // Vibración al presionar el botón "Next"
            }) {
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
            .padding(.bottom, 30)
        }
        .background(Color(red: 249/255, green: 249/255, blue: 253/255))
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            backButton
        }
    }

    // Botón de retroceso
    private var backButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: goBack) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
                    .imageScale(.large)
            }
        }
    }
    
    // Acción para retroceder
    func goBack() {
        progressViewModel.decreaseProgress() // Decrementar el progreso cuando se retroceda
        presentationMode.wrappedValue.dismiss() // Volver atrás
    }
    
    // Función para activar la vibración
    func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

struct GymEquipmentButton: View {
    let imageName: String
    let index: Int
    @ObservedObject var viewModel: GymEquipmentViewModel
    
    var body: some View {
        Button(action: {
            viewModel.selectOption(index)
            triggerHapticFeedback() // Vibración al seleccionar la opción
        }) {
            ZStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150) // Tamaño de la imagen
                    .clipped()
                    .cornerRadius(12) // Mayor cornerRadius para un borde más redondeado
                    .overlay(
                        RoundedRectangle(cornerRadius: 13) // Borde más grueso si está seleccionad
                            .stroke(viewModel.selectedIndex == index ? Color.blue : Color.clear, lineWidth: viewModel.selectedIndex == index ? 6 : 4) // Borde más grueso (8) cuando está seleccionado
                    )
                    .scaleEffect(viewModel.selectedIndex == index ? 1.01 : 0.95) // Aumentar la escala cuando está seleccionado
                    .shadow(color: viewModel.selectedIndex == index ? Color.blue.opacity(0.5) : Color.clear, radius: 7, x: 0, y: 0)
                    .overlay(
                        // Filtro azul sobre la imagen si está seleccionada
                        Group {
                            if viewModel.selectedIndex == index {
                                Color.blue.opacity(0.1) // Filtro azul
                                    .clipShape(RoundedRectangle(cornerRadius: 12)) // Aplicar cornerRadius al filtro
                            } else {
                                Color.clear
                            }
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12)) // Aseguramos que la imagen tenga el cornerRadius
                // Checkmark si está seleccionado
                if viewModel.selectedIndex == index {
                    HStack {
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                            .padding(.top, -61)
                            .padding(.trailing, 10)
                    }
                }
            }
        }
        .padding(.horizontal, 20) // Aumento del padding horizontal para separar las imágenes
        .padding(.vertical, 10) // Añadí algo de espacio vertical entre las imágenes
    }

    // Función para activar la vibración
    func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

// MARK: - Preview
struct GymEquipmentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GymEquipmentView(progressViewModel: ProgressViewModel())
        }
    }
}

