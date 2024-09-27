import SwiftUI

struct GenderSelectionView: View {
    @ObservedObject var viewModel: GenderSelectionViewModel
    @State private var navigateToGoal = false // Estado para controlar la navegación

    var body: some View {
        VStack {
            // Barra de progreso dentro de la vista
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: 300, height: 6)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                
                Rectangle()
                    .frame(width: CGFloat(0.5) * 300, height: 6)
                    .foregroundColor(.blue)
            }
            .padding(.top, 20)
            .padding(.horizontal)

            // Título de la pantalla
            Text("What's your gender?")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)

           
            HStack {
                
                Text("This will help us tailor your workout to match your metabolic rate perfectly.")
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
             
            }
            .padding()

            // Opciones de género
            HStack(spacing: 20) {
                GenderSelectionCard(gender: .male, isSelected: viewModel.selectedGender == .male) {
                    viewModel.selectGender(.male)
                }
                
                GenderSelectionCard(gender: .female, isSelected: viewModel.selectedGender == .female) {
                    viewModel.selectGender(.female)
                }
            }
            .padding()

            // Botón de continuar
            if viewModel.selectedGender != nil {
                Button(action: {
                    viewModel.continueToNextScreen()
                    navigateToGoal = true // Cambia el estado para activar el NavigationLink
                }) {
                    Text("Continue")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, 20)
                .background(
                    NavigationLink(destination: GoalView(), isActive: $navigateToGoal) {
                        EmptyView()
                    }
                )
            }
        }
        .navigationBarBackButtonHidden(true) // Oculta el botón de regreso
        .navigationBarTitle("", displayMode: .inline)
    }
}

// Vista de la tarjeta de selección de género
struct GenderSelectionCard: View {
    let gender: Gender
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: gender == .male ? "person.fill" : "person.fill") // Asegúrate de usar un ícono adecuado
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Text(gender == .male ? "Male" : "Female")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding()
            .frame(width: 150, height: 200)
            .background(isSelected ? Color.blue.opacity(0.3) : Color.gray.opacity(0.1))
            .cornerRadius(15)
            .shadow(radius: 5)
        }
    }
}

// Preview para la vista de selección de género
struct GenderSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectionView(viewModel: GenderSelectionViewModel())
    }
}

