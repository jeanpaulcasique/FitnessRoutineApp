import SwiftUI
import SDWebImageSwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @State private var navigateToFase1 = false
    @State private var isButtonDisabled = false
    @StateObject var genderSelectionViewModel = GenderSelectionViewModel()
    @StateObject var progressViewModel = ProgressViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                GeometryReader { geometry in
                    AnimatedImage(name: "loginBackground.gif")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                }

                VStack {
                    Spacer()

                    Button(action: {
                        guard !isButtonDisabled else { return }
                        isButtonDisabled = true
                        
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            navigateToFase1 = true
                        }
                    }) {
                        Text("START")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isButtonDisabled ? Color.gray : Color.yellow)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                    .disabled(isButtonDisabled)
                    .padding(.bottom, 0)

                    NavigationLink(
                        destination: Fase1View(
                            genderSelectionViewModel: genderSelectionViewModel,
                            progressViewModel: progressViewModel
                        ),
                        isActive: $navigateToFase1
                    ) {
                        EmptyView()
                    }

                    Text("¿Ya eres usuario?")
                        .foregroundColor(.white)
                        .padding(.top, 5)

                    Button(action: {
                        viewModel.showExistingAccountOptions()
                    }) {
                        Text("Continuar con tu cuenta existente")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .underline()
                    }
                    .padding(.bottom, 18)
                }
                .padding(.bottom, 0)
                .edgesIgnoringSafeArea(.bottom)
                .allowsHitTesting(!viewModel.showLoginOptions)
                .onAppear {
                    isButtonDisabled = false
                }

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
                    withAnimation(nil) {
                        viewModel.hideLoginOptions()
                    }
                }

            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Button(action: {
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

