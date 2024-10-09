import SwiftUI

struct ProgressBarView: View {
    @ObservedObject var progressViewModel: ProgressViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height: CGFloat = 10
            
            // Barra de fondo
            RoundedRectangle(cornerRadius: height / 2)
                .fill(Color.gray.opacity(0.3))
                .frame(width: width, height: height)
            
            // Calcular el ancho del progreso basado en el progreso actual
            let progressWidth = width * CGFloat(progressViewModel.currentProgress) / CGFloat(progressViewModel.totalSteps)
            
            RoundedRectangle(cornerRadius: height / 2)
                .fill(Color.blue)
                .frame(width: progressWidth, height: height)
                .animation(.easeInOut, value: progressViewModel.currentProgress) // Animación al cambiar el progreso
        }
        .frame(height: 20) // Fija la altura del contenedor
    }
}

// Vista previa para ProgressBarView
struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(progressViewModel: ProgressViewModel())
            .padding()
            .frame(width: 300, height: 50)
    }
}

