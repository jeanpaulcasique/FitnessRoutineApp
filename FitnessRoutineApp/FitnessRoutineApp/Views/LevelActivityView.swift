import SwiftUI

struct LevelActivityView: View {
    @StateObject private var viewModel = LevelActivityViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToNextView = false // Estado para controlar la navegación

    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 20)
            // Espacio desde la parte superior de la pantalla

            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.horizontal, 20)

            // Título de la pantalla
            Text("What's your activity level?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black) // Color negro para el título

            // Imagen de nivel de actividad
            Image(viewModel.currentImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)

            // Descripción del nivel de actividad
            Text(viewModel.activityDescription)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(.black) // Color negro para la descripción

            // Slider personalizado
            Slider(value: $viewModel.sliderValue, in: 0...3, step: 1)
                .accentColor(.blue)
                .padding(.horizontal, 30)

            // Etiquetas del slider
            HStack {
                Text("Sedentary")
                    .foregroundColor(.black) // Color negro para la etiqueta izquierda
                Spacer()
                Text("Very active")
                    .foregroundColor(.black) // Color negro para la etiqueta derecha
            }
            .padding(.horizontal, 30)

            Spacer()

            // Botón Siguiente
            NavigationLink(
                destination: WorkoutLevelView(progressViewModel: progressViewModel),
                isActive: $navigateToNextView
            ) {
                Button(action: {
                    navigateToNextView = true
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
            }
            .padding(.horizontal, 20)
            .simultaneousGesture(TapGesture().onEnded {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
            })
            .padding(.bottom, 20)
        }
        .background(Color(red: 249/255, green: 249/255, blue: 253/255))
        .navigationTitle("") // Título vacío
        .navigationBarTitleDisplayMode(.inline) // Estilo inline
        .navigationBarBackButtonHidden(false) // Solo muestra la flecha de back
    }
}

// Vista previa para el Canvas
struct LevelActivityView_Previews: PreviewProvider {
    static var previews: some View {
        LevelActivityView(progressViewModel: ProgressViewModel())
    }
}

