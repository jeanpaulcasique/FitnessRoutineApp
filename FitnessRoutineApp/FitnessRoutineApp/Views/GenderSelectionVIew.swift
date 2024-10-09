import SwiftUI

struct GenderSelectionView: View {
    @ObservedObject var viewModel: GenderSelectionViewModel
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToGoal = false // Estado para controlar la navegación
    @State private var showInfo = false // Estado para mostrar/ocultar el texto de información
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // Para detectar el retroceso

    var body: some View {
        VStack {
            // Barra de progreso controlada por el ProgressViewModel
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal)

            // Título de la pantalla
            Text("What's your gender?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            // Cuadro de información interactivo
            VStack {
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(.blue)
                        .font(.title)
                        .onTapGesture {
                            // Animación para expandir/colapsar el texto
                            withAnimation {
                                showInfo.toggle()
                            }
                        }
                    
                    Text("Why we ask this?")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                if showInfo {
                    Text("This will help us tailor your workout to match your metabolic rate perfectly.")
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .transition(.opacity) // Animación de aparición
                        .padding(.horizontal)
                }
            }
            .padding()

            // Opciones de género con animación al seleccionar
            HStack(spacing: 30) {
                GenderSelectionCard(gender: .male, isSelected: viewModel.selectedGender == .male) {
                    viewModel.selectGender(.male)
                    // No se avanza el progreso aquí
                }
                .scaleEffect(viewModel.selectedGender == .male ? 1.1 : 1.0) // Escala al seleccionar
                .animation(.easeInOut(duration: 0.3), value: viewModel.selectedGender) // Animación suave

                GenderSelectionCard(gender: .female, isSelected: viewModel.selectedGender == .female) {
                    viewModel.selectGender(.female)
                    // No se avanza el progreso aquí
                }
                .scaleEffect(viewModel.selectedGender == .female ? 1.1 : 1.0) // Escala al seleccionar
                .animation(.easeInOut(duration: 0.3), value: viewModel.selectedGender) // Animación suave
            }
            .padding()

            Spacer() // Añadimos un Spacer para empujar el botón hacia abajo

            // Botón de continuar
            if viewModel.selectedGender != nil {
                Button(action: {
                    progressViewModel.advanceProgress() // Avanza el progreso al seleccionar "Next"
                    navigateToGoal = true // Cambia el estado para activar el NavigationLink
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
                NavigationLink(destination: GoalView(viewModel: GoalViewModel(), progressViewModel: progressViewModel), isActive: $navigateToGoal) {
                    EmptyView()
                }
                .padding(.bottom, 10) // Alinea el botón con otras pantallas colocando más espacio en la parte inferior
            }
        }
        .navigationBarBackButtonHidden(true) // Oculta el botón de regreso
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    progressViewModel.decreaseProgress() // Retroceder el progreso
                    self.presentationMode.wrappedValue.dismiss() // Retroceder a la vista anterior
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .font(.title)
                }
            }
        }
        .onAppear {
            if progressViewModel.currentProgress < 3 { // Cambia el 3 al máximo de progreso permitido
                progressViewModel.advanceProgress() // Avanza el progreso solo cuando se entra a la vista
            }
        }
        .onDisappear {
            if !navigateToGoal {
                progressViewModel.decreaseProgress() // Retrocede el progreso si no navegamos hacia GoalView
            }
        }
        .background(Color(red: 249/255, green: 249/255, blue: 253/255)) // Usar el color
    }
}

// Vista de la tarjeta de selección de género
// Vista de la tarjeta de selección de género
struct GenderSelectionCard: View {
    let gender: Gender
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Button(action: action) {
                Image(gender == .male ? "male" : "female") // Imágenes desde los assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 270) // Aumentar el tamaño del icono
                    .cornerRadius(15) // Bordes redondeados
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3) // Borde azul si está seleccionado
                    )
            }
            .scaleEffect(isSelected ? 1.1 : 1.0) // Escala al seleccionar
            .animation(.easeInOut(duration: 0.3), value: isSelected) // Animación suave
            .shadow(color: isSelected ? Color.blue.opacity(0.5) : Color.clear, radius: 10, x: 0, y: 5)

            // Checkmark solo si la opción está seleccionada
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
                    .offset(x: 60, y: -110) // Ajusta la posición del checkmark según tu diseño
                    .animation(.easeInOut(duration: 0.3)) // Animación suave para el checkmark
            }
        }
    }
}


// Preview para GenderSelectionView
struct GenderSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectionView(viewModel: GenderSelectionViewModel(), progressViewModel: ProgressViewModel())
    }
}

