import SwiftUI

struct WeightView: View {
    @StateObject private var viewModel = WeightViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var isNavigatingToTargetWeightView = false // Estado para controlar la navegación
    var userHeight: Double

    @Environment(\.presentationMode) var presentationMode // Para manejar la navegación

    var body: some View {
        VStack {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)

            // Título
            Text("What's your current weight?")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.black)
                .padding(.top, 40)
                .padding(.bottom, 10)

            Spacer(minLength: 100)

            // Selector de unidades (kg / lb)
            HStack {
                Button(action: {
                    if !viewModel.isKgSelected {
                        viewModel.toggleUnit()
                    }
                }) {
                    Text("kg")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(viewModel.isKgSelected ? .white : .black)
                        .padding()
                        .background(viewModel.isKgSelected ? Color.black : Color.clear)
                        .cornerRadius(15)
                }
                
                Button(action: {
                    if viewModel.isKgSelected {
                        viewModel.toggleUnit()
                    }
                }) {
                    Text("lb")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(!viewModel.isKgSelected ? .white : .black)
                        .padding()
                        .background(!viewModel.isKgSelected ? Color.black : Color.clear)
                        .cornerRadius(15)
                }
            }
            .padding(.bottom, 30)

            // Definir límites del slider
            let minWeightKg: Double = 20
            let maxWeightKg: Double = 200
            let minWeightLb: Double = 44.09 // 20 kg en libras
            let maxWeightLb: Double = 440.92 // 200 kg en libras
            
            // Selector de peso
            Slider(value: Binding(
                get: {
                    viewModel.isKgSelected ? viewModel.selectedWeightKg : viewModel.selectedWeightLb
                },
                set: { newValue in
                    if viewModel.isKgSelected {
                        viewModel.updateWeight(newWeight: newValue)
                    } else {
                        viewModel.updateWeight(newWeight: newValue / 2.20462) // Convertir de lb a kg
                    }
                }
            ), in: viewModel.isKgSelected ? minWeightKg...maxWeightKg : minWeightLb...maxWeightLb, step: 0.1)
            .accentColor(Color.blue)
            .padding(.horizontal, 30)

            // Mostrar el peso seleccionado
            Text(String(format: "%.1f", viewModel.weightInPreferredUnit) + (viewModel.isKgSelected ? " kg" : " lb"))
                .font(.system(size: 44, weight: .bold))
                .foregroundColor(Color.black)
                .padding(.bottom, 10)

            // Mostrar el IMC
            let bmi = viewModel.calculateBMI(heightInCm: userHeight)
            Text(String(format: "BMI: %.1f", bmi))
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(Color.black)
                .padding(.bottom, 30)

            Spacer(minLength: 200)

            // Botón Next con navegación
            NavigationLink(destination: TargetWeightView(viewModel: TargetWeightViewModel(), progressViewModel: progressViewModel), isActive: $isNavigatingToTargetWeightView) {
                Button(action: {
                    // Activar vibración
                    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                    impactFeedback.impactOccurred()
                    
                    progressViewModel.advanceProgress()
                    isNavigatingToTargetWeightView = true
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
                .padding(.bottom, 15)
            }
        }
        .onAppear {
            viewModel.updateWeight(newWeight: viewModel.selectedWeightKg)
        }
        .navigationTitle("") // Título vacío
        .navigationBarTitleDisplayMode(.inline) // Mantiene el estilo inline
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
        .background(Color(red: 249/255, green: 249/255, blue: 253/255)) // Fondo añadido
    }
}

struct WeightView_Previews: PreviewProvider {
    static var previews: some View {
        WeightView(progressViewModel: ProgressViewModel(), userHeight: 170.0)
    }
}

