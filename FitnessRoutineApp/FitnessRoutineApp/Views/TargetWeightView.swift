import SwiftUI

struct TargetWeightView: View {
    @ObservedObject var viewModel: TargetWeightViewModel
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToHowOftenView = false // Estado para controlar la navegación

    var body: some View {
        VStack {
            // Barra de progreso simulada
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)

            // Título principal
            Text("What's your target weight?")
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.top, 40)
                .padding(.bottom, 70)
                .foregroundColor(.black)

            // Selector de kg y lb
            HStack {
                Button(action: {
                    viewModel.toggleUnit(toKg: true)
                }) {
                    Text("kg")
                        .font(.system(size: 18, weight: .bold))
                        .frame(width: 60, height: 40)
                        .background(viewModel.isKgSelected ? Color.black : Color.gray.opacity(0.2))
                        .foregroundColor(viewModel.isKgSelected ? Color.white : Color.black)
                        .cornerRadius(20)
                }
                Button(action: {
                    viewModel.toggleUnit(toKg: false)
                }) {
                    Text("lb")
                        .font(.system(size: 18, weight: .bold))
                        .frame(width: 60, height: 40)
                        .background(viewModel.isKgSelected ? Color.gray.opacity(0.2) : Color.black)
                        .foregroundColor(viewModel.isKgSelected ? Color.black : Color.white)
                        .cornerRadius(20)
                }
            }
            .padding(.bottom, 20)
            .padding(.top, 100)
            
            // Peso objetivo
            Text("\(Int(viewModel.weightInPreferredUnit)) \(viewModel.isKgSelected ? "kg" : "lb")")
                .font(.system(size: 48, weight: .bold))
                .padding(.bottom, 5)
                .foregroundColor(.black)

            // Deslizador de peso
            Slider(value: $viewModel.selectedWeightKg, in: 60...90, step: 0.5)
                .accentColor(.blue)
                .padding(.horizontal, 40)
                .onChange(of: viewModel.selectedWeightKg) { newValue in
                    viewModel.updateWeight(newWeight: newValue)
                }

            Spacer()

            // Botón Next con navegación
            NavigationLink(
                destination: HowOftenView(viewModel: HowOftenViewModel(), progressViewModel: progressViewModel),
                isActive: $navigateToHowOftenView
            ) {
                EmptyView()
            }

            Button(action: {
                navigateToHowOftenView = true
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
            .padding(.bottom, 20)
        }
        .onAppear {
            viewModel.updateHealthBenefitMessage()
        }
        .navigationTitle("") // Título vacío
        .navigationBarTitleDisplayMode(.inline) // Mantiene el estilo inline
        .navigationBarBackButtonHidden(false) // Muestra solo el ícono sin texto
        .background(Color(red: 249/255, green: 249/255, blue: 253/255)) // Fondo añadido
    }
}

struct TargetWeightView_Previews: PreviewProvider {
    static var previews: some View {
        TargetWeightView(viewModel: TargetWeightViewModel(), progressViewModel: ProgressViewModel())
    }
}

