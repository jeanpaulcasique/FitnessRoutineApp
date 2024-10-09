import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @State private var navigateToGenderSelection = false // Variable de estado para la navegación

    var body: some View {
        NavigationView {  // Envuelve todo el contenido en NavigationView
            ZStack {
                // Fondo blanco que se ignora cuando las opciones de login están visibles
                Color.white
                    .ignoresSafeArea()
                    .onTapGesture {
                        if viewModel.showLoginOptions {
                            viewModel.hideLoginOptions()
                        }
                    }
                    .allowsHitTesting(!viewModel.showLoginOptions) // Deshabilita la interacción cuando se muestran las opciones

                VStack {
                    Spacer()

                    // Botón estilizado de "Inicio"
                    Button(action: {
                        navigateToGenderSelection = true  // Cambia la variable para navegar
                    }) {
                        Text("START")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }

                    // Enlace de navegación a GenderSelectionView
                    NavigationLink(destination: GenderSelectionView(viewModel: GenderSelectionViewModel(), progressViewModel: ProgressViewModel()), isActive: $navigateToGenderSelection) {
                        EmptyView()
                    }

                    Text("¿Ya eres usuario?")
                        .foregroundColor(.gray)
                        .padding(.top, 10)

                    // Botón para continuar con la cuenta existente
                    Button(action: {
                        viewModel.showExistingAccountOptions()
                    }) {
                        Text("Continuar con tu cuenta existente")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                    .padding(.bottom, 05)
                }
                .allowsHitTesting(!viewModel.showLoginOptions) // Deshabilita la interacción con los botones de fondo

                // Cuadro de opciones de inicio de sesión
                if viewModel.showLoginOptions {
                    optionsView
                }
            }
        }
    }

    // Vista de opciones de inicio de sesión
    var optionsView: some View {
        ZStack {
            // Cubre la pantalla completa con un fondo oscuro semitransparente
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.hideLoginOptions()
                }

            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.hideLoginOptions()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .font(.title)
                    }
                    .padding(.top, 10)
                    .padding(.trailing, 10)
                }

                Button(action: {
                    viewModel.signInWithApple()
                }) {
                    HStack {
                        Image(systemName: "applelogo")
                        Text("Iniciar sesión con Apple")
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }

                Button(action: {
                    viewModel.signInWithGoogle()
                }) {
                    HStack {
                        Image(systemName: "globe")
                        Text("Google")
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }

                Button(action: {
                    viewModel.signInWithFacebook()
                }) {
                    HStack {
                        Image(systemName: "facebook")
                        Text("Facebook")
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .padding()
            .background(Color.black.opacity(0.6))
            .cornerRadius(16)
            .shadow(radius: 10)
            .frame(maxWidth: 300)
        }
    }
}

// Preview para LoginView
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

