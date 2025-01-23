import SwiftUI
import UIKit

struct BirthYearView: View {
    @ObservedObject var viewModel: BirthYearViewModel
    @ObservedObject var progressViewModel: ProgressViewModel
    
    // Estado para controlar la navegación
    @State private var isNavigatingToNextScreen = false

    @Environment(\.presentationMode) var presentationMode // Para manejar la navegación

    var body: some View {
        VStack {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            
            // Título
            Text("What's your birth year?")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
                .foregroundColor(.black)
            
            // Descripción
            Text("This will help us tailor workouts to suit your body's capabilities and ensure safe training.")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.horizontal, 30)
                .padding(.top, 10)
                .multilineTextAlignment(.center)
            
            // Selector de año
            Picker("Select your birth year", selection: $viewModel.selectedYear) {
                ForEach(1900..<Calendar.current.component(.year, from: Date()) + 1, id: \.self) { year in
                    let yearText = "\(year)" // Convierte el año a texto
                    Text(yearText) // Usa el texto en el Picker
                        .font(.system(size: viewModel.selectedYear == year ? 36 : 24, weight: .bold))
                        .foregroundColor(viewModel.selectedYear == year ? .blue : .gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)
                        .scaleEffect(viewModel.selectedYear == year ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: viewModel.selectedYear)
                        .tag(year)
                        .onChange(of: viewModel.selectedYear) { _ in
                            // Vibrar al cambiar el año
                            vibrate()
                        }
                }
            }
            .pickerStyle(WheelPickerStyle()) // Mantener el estilo de rueda
            .background(Color.clear) // Eliminar el fondo gris del Picker
            .frame(height: 350)
            .clipped()
            .padding(.horizontal, 16)

            Spacer()
            
            // Botón "Next"
            Button(action: {
                if viewModel.canProceed {
                    progressViewModel.advanceProgress()
                    isNavigatingToNextScreen = true
                    // Vibrar al presionar el botón
                    vibrate()
                }
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
                    .cornerRadius(12)
                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 5)
            }
            .padding(.horizontal, 20)
            .disabled(!viewModel.canProceed) // Deshabilitar si no se puede avanzar

            // Navegación condicional
            NavigationLink(destination: HeightView(viewModel: HeightViewModel(), progressViewModel: progressViewModel), isActive: $isNavigatingToNextScreen) {
                EmptyView() // Vista vacía para la navegación
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true) // Ocultar el botón de retroceso predeterminado
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Regresa a la pantalla anterior
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue) // Azul
                        .imageScale(.large) // Tamaño de la flecha igual a las otras pantallas
                }
            }
        }
        .background(Color(red: 249/255, green: 249/255, blue: 253/255))
    }

    // Función para vibrar
    private func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

// Preview
struct BirthYearView_Previews: PreviewProvider {
    static var previews: some View {
        BirthYearView(viewModel: BirthYearViewModel(), progressViewModel: ProgressViewModel())
    }
}

