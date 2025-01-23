import SwiftUI

struct NewScreenView: View {
  @StateObject private var viewModel = NewScreenViewModel()
  @ObservedObject var progressViewModel: ProgressViewModel
  @Environment(\.presentationMode) private var presentationMode

  var body: some View {
    VStack(spacing: 20) {
      // Barra de progreso
      ProgressBarView(progressViewModel: progressViewModel)
        .padding(.top, 20)
        .padding(.horizontal, 20)

      // Título principal
      Text("Which place do you prefer for your workout?")
        .font(.system(size: 24, weight: .bold))
        .multilineTextAlignment(.center)
        .foregroundColor(.black)
        .padding(.top, 20)

      // Lista de opciones
      ForEach(viewModel.options.indices, id: \.self) { index in
        HStack {
          Image(systemName: viewModel.options[index].icon)
            .foregroundColor(index == viewModel.selectedIndex ? .blue : .black)

          Text(viewModel.options[index].title)
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
          // Vibración al seleccionar una opción
          let generator = UIImpactFeedbackGenerator(style: .medium)
          generator.impactOccurred()

          viewModel.selectOption(at: index)
        }
      }
      .padding(.horizontal, 20)

      Spacer()

      // Botón para avanzar
      Button(action: {
        // Vibración al presionar el botón Next
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        print("Next button tapped. Selected option: \(viewModel.selectedIndex ?? -1)")
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
      .padding(.bottom, 50)
    }
    .background(Color(red: 249 / 255, green: 249 / 255, blue: 253 / 255))
    .edgesIgnoringSafeArea(.bottom)
    .navigationBarBackButtonHidden(true) // Eliminar el botón de retroceso de la barra
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button(action: {
          // Acción de retroceso
          self.presentationMode.wrappedValue.dismiss()
        }) {
          // Flecha de retroceso con color azul
          Image(systemName: "chevron.left") // Icono de flecha
            .foregroundColor(.blue) // Flecha de color azul
        }
      }
    }
  }
}

struct NewScreenView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      NewScreenView(progressViewModel: ProgressViewModel())
    }
  }
}

