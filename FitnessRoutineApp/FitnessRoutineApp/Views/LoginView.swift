import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @State private var navigateToGenderSelection = false
    // Inicializamos los ViewModels fuera del cuerpo de la vista para que se reutilicen.
    @StateObject var genderSelectionViewModel = GenderSelectionViewModel()
    @StateObject var progressViewModel = ProgressViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                    .onTapGesture {
                        if viewModel.showLoginOptions {
                            viewModel.hideLoginOptions()
                        }
                    }
                    .allowsHitTesting(!viewModel.showLoginOptions)  // Deshabilitar interacción solo si las opciones están visibles.

                VStack {
                    Spacer()

                    Button(action: {
                        navigateToGenderSelection = true
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

                    // Usamos los ViewModels inicializados externamente
                    NavigationLink(destination: GenderSelectionView(viewModel: genderSelectionViewModel, progressViewModel: progressViewModel), isActive: $navigateToGenderSelection) {
                        EmptyView()
                    }

                    Text("¿Ya eres usuario?")
                        .foregroundColor(.gray)
                        .padding(.top, 10)

                    Button(action: {
                        viewModel.showExistingAccountOptions()
                    }) {
                        Text("Continuar con tu cuenta existente")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                    .padding(.bottom, 5)  // Se cambió de 05 a 5 para seguir convención
                }
                .allowsHitTesting(!viewModel.showLoginOptions)

                if viewModel.showLoginOptions {
                    optionsView
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true) // Mantén oculto el botón de retroceso si es el comportamiento esperado.
        }
    }

    var optionsView: some View {
        ZStack {
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

                // Botones reutilizados
                socialLoginButton(imageName: "applelogo", text: "Iniciar sesión con Apple", backgroundColor: .black) {
                    viewModel.signInWithApple()
                }

                socialLoginButton(imageName: "globe", text: "Google", backgroundColor: .red) {
                    viewModel.signInWithGoogle()
                }

                socialLoginButton(imageName: "facebook", text: "Facebook", backgroundColor: .blue) {
                    viewModel.signInWithFacebook()
                }
            }
            .padding()
            .background(Color.black.opacity(0.6))
            .cornerRadius(16)
            .shadow(radius: 10)
            .frame(maxWidth: 300)
        }
    }

    // Función auxiliar para crear botones de inicio de sesión
    func socialLoginButton(imageName: String, text: String, backgroundColor: Color, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }) {
            HStack {
                Image(systemName: imageName)
                Text(text)
                    .fontWeight(.bold)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

