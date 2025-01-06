import SwiftUI

struct WorkoutLevelView: View {
    @StateObject private var viewModel = WorkoutLevelViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel // Se incluye el ProgressViewModel

    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 20)
            
            // Barra de progreso reutilizable
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.horizontal, 20)

            // Título
            Text("Choose your preferred workout level")
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding(.horizontal, 20)

            // Opciones de niveles
            ForEach(viewModel.levels.indices, id: \.self) { index in
                HStack {
                    Image(systemName: viewModel.levels[index].1)
                        .foregroundColor(index == viewModel.selectedIndex ? .blue : .black)

                    Text(viewModel.levels[index].0)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(index == viewModel.selectedIndex ? .blue : .black)

                    Spacer()

                    if index == viewModel.selectedIndex {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(index == viewModel.selectedIndex ? Color.blue.opacity(0.1) : Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(index == viewModel.selectedIndex ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
                )
                .onTapGesture {
                    viewModel.selectLevel(at: index)
                }
            }
            .padding(.horizontal, 20)

            Spacer()

            // Botón Siguiente
            Button(action: {
                // Acción al presionar el botón
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
        .background(Color(red: 249 / 255, green: 249 / 255, blue: 253 / 255))
    }
}

// Vista previa
struct WorkoutLevelView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLevelView(progressViewModel: ProgressViewModel())
    }
}
