import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @State private var navigateToGenderSelection = false
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
                    .allowsHitTesting(!viewModel.showLoginOptions)

                VStack {
                    Spacer()

                    Button(action: {
                        // Vibración al presionar el botón
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()

                        // Navegación rápida al presionar START
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

                    // Navegación sin animaciones
                    NavigationLink(
                        destination: GenderSelectionView(
                            viewModel: genderSelectionViewModel,
                            progressViewModel: progressViewModel
                        ),
                        isActive: $navigateToGenderSelection
                    ) {
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
                    .padding(.bottom, 5)
                }
                .allowsHitTesting(!viewModel.showLoginOptions)

                if viewModel.showLoginOptions {
                    optionsView
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }

    var optionsView: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    // Cierra el optionsView de inmediato sin animación
                    withAnimation(nil) {
                        viewModel.hideLoginOptions()
                    }
                }

            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Button(action: {
                        // Cierra el optionsView de inmediato sin animación
                        withAnimation(nil) {
                            viewModel.hideLoginOptions()
                        }
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .font(.title)
                    }
                    .padding(.top, 10)
                    .padding(.trailing, 10)
                }

                // Botones de inicio de sesión
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

