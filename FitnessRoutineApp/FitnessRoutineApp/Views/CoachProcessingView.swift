import SwiftUI

struct CoachProcessingView: View {
    @StateObject private var viewModel = CoachProcessingViewModel()
    @State private var progress: Double = 0.0 // Simulando 47%

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image("coach")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .clipShape(Circle())

            Text("Your coach is busy working for you...")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            VStack(alignment: .leading, spacing: 10) {
                ForEach(viewModel.tasks.indices, id: \.self) { index in
                    HStack {
                        if index < Int(progress * 4) { // Si la tarea está completa
                            Text("• \(viewModel.tasks[index].text): ")
                                .font(.body)
                                .foregroundColor(.black) +
                            Text(viewModel.tasks[index].value)
                                .fontWeight(.bold)
                            
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        } else { // Si la tarea aún no se ha completado
                            Text("• \(viewModel.tasks[index].text)")
                                .font(.body)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    }
                }
            }
            .padding(.horizontal)

            // Barra de progreso personalizada
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 30)

                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .frame(width: geo.size.width * progress, height: 30)
                }
                .overlay(
                    Text("\(Int(progress * 100))%")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading, 10),
                    alignment: .leading
                )
            }
            .frame(height: 30)
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .onAppear {
            // Simulación de carga progresiva
            withAnimation(.easeInOut(duration: 3)) {
                progress = 1.0
            }
        }
    }
}

struct CoachProcessingView_Previews: PreviewProvider {
    static var previews: some View {
        CoachProcessingView()
    }
}

