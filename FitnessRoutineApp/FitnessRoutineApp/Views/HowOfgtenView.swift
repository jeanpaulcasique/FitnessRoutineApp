import SwiftUI

struct CustomSliderView: View {
    @ObservedObject var viewModel: HowOftenViewModel
    let totalSteps = 4 // Número total de puntos en el slider

    var body: some View {
        VStack {
            HStack {
                Text("Less")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("More")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 20)
            
            ZStack {
                // Fondo del slider (track)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 20)
                    .padding(.horizontal, 20)
                
                // Círculos de los pasos
                HStack(spacing: 0) {
                    ForEach(0..<totalSteps, id: \.self) { index in
                        Spacer()
                        Circle()
                            .fill(index == viewModel.currentIndex ? Color.blue : Color.blue.opacity(0.3))
                            .frame(width: index == viewModel.currentIndex ? 24 : 12, height: index == viewModel.currentIndex ? 24 : 12)
                            .background(Circle().stroke(Color.white, lineWidth: 4))
                            .onTapGesture {
                                viewModel.currentIndex = index
                            }
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.top, 20)
    }
}

struct HowOftenView: View {
    @ObservedObject var viewModel: HowOftenViewModel
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToLevelActivityView = false // Estado para navegar

    var body: some View {
        VStack {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)

            // Título
            Text("How often would you like to work out?")
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.top, 40)
                .padding(.bottom, 20)
                .foregroundColor(.black)

            // Imagen que cambia según la posición del slider
            Image(viewModel.currentImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding(.bottom, 20)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < -50 {
                                viewModel.nextImage()
                            } else if value.translation.width > 50 {
                                viewModel.previousImage()
                            }
                        }
                )

            // Slider personalizado
            CustomSliderView(viewModel: viewModel)

            Spacer()

            // NavigationLink oculto para la transición a LevelActivityView
            NavigationLink(
                destination: LevelActivityView(progressViewModel: progressViewModel),
                isActive: $navigateToLevelActivityView
            ) {
                EmptyView()
            }

            // Botón Next con estilo
            Button(action: {
                navigateToLevelActivityView = true // Activa la navegación
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
            .simultaneousGesture(TapGesture().onEnded {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
            })
            .padding(.bottom, 20)
        }
        .background(Color(red: 249/255, green: 249/255, blue: 253/255)) // Fondo añadido
    }
}


struct HowOftenView_Previews: PreviewProvider {
    static var previews: some View {
        HowOftenView(viewModel: HowOftenViewModel(), progressViewModel: ProgressViewModel())
    }
}

