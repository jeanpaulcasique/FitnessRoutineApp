import SwiftUI

struct LevelActivityView: View {
    @StateObject private var viewModel = LevelActivityViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToNextView = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)

            // Título principal
            Text("What's your activity level?")
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.top, 40)
                .padding(.bottom, 20)
                .foregroundColor(.black)

            // Imagen representativa
            Image(viewModel.currentImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)

            // Descripción de la actividad
            Text(viewModel.activityDescription)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(.black)

            // Slider para ajustar el nivel de actividad
            Slider(value: $viewModel.sliderValue, in: 0...3, step: 1)
                .accentColor(.blue)
                .padding(.horizontal, 30)

            // Texto indicando el rango de actividad
            HStack {
                Text("Sedentary")
                    .foregroundColor(.black)
                Spacer()
                Text("Very active")
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 30)

            Spacer()

            // Botón para navegar a la siguiente pantalla
            Button(action: {
                let generator = UIImpactFeedbackGenerator(style: .medium) // Vibración de impacto
                generator.impactOccurred() // Genera la vibración
                navigateToNextView = true
            }) {
                Text("Next")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 5)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)

            NavigationLink(destination: WorkoutLevelView(progressViewModel: progressViewModel), isActive: $navigateToNextView) {
                EmptyView()
            }
        }
        .background(Color(red: 249/255, green: 249/255, blue: 253/255).ignoresSafeArea())
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue) // Cambié el color de la flecha a azul
                }
            }
        }
    }
}

struct LevelActivityView_Previews: PreviewProvider {
    static var previews: some View {
        LevelActivityView(progressViewModel: ProgressViewModel())
    }
}

