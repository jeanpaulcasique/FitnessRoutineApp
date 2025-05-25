import SwiftUI
import SDWebImageSwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @StateObject var genderSelectionViewModel = GenderSelectionViewModel()
    @StateObject var progressViewModel = ProgressViewModel()
    @EnvironmentObject var sessionManager: UserSessionManager

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
                    
                    
                    Button(action: viewModel.handleStartButtonTap(sessionManager: sessionManager)) {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                .frame(maxWidth: .infinity)
                                .padding()
                        } else {
                            Text("START")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .background(viewModel.isDisabled ? Color.gray : Color.yellow)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .disabled(viewModel.isDisabled)
                    .padding(.bottom, 0)

                    NavigationLink(
                        destination: Fase1View(
                            genderSelectionViewModel: genderSelectionViewModel,
                            progressViewModel: progressViewModel
                        ),
                        isActive: $viewModel.navigateToFase1
                    ) {
                        EmptyView()
                    }

                    Text("¿Ya eres usuario?")
                        .foregroundColor(.white)
                        .padding(.top, 5)

                    Button(action: viewModel.showExistingAccountOptions) {
                        Text("Continuar con tu cuenta existente")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .underline()
                    }
                    .padding(.bottom, 18)
                }
                .padding(.bottom, 0)
                .allowsHitTesting(!viewModel.showLoginOptions)

                if viewModel.showLoginOptions {
                    optionsView
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                viewModel.resetButton()
            }
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
        Button(action: action) {
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
            .environmentObject(UserSessionManager())
    }
}

