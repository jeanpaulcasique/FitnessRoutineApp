import SwiftUI

struct HowOftenView: View {
    @ObservedObject var viewModel: HowOftenViewModel
    @State private var navigateToNextView = false
    @ObservedObject var progressViewModel: ProgressViewModel // Aquí agregamos el ProgressViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)

            // Título principal
            Text("How often would you like to work out?")
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.top, 40)
                .padding(.bottom, 20)
                .foregroundColor(.black)

            // Imagen representativa
            Image(viewModel.currentImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.bottom, 10)

            VStack(spacing: 4) {
                Text("\(viewModel.currentIndex + 1) time\(viewModel.currentIndex == 0 ? "" : "s") / week")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)

                Text(viewModel.descriptionText)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.bottom, 30)

            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 4)

                    HStack(spacing: 0) {
                        ForEach(0..<viewModel.imageCount, id: \.self) { index in
                            Spacer()
                            Circle()
                                .fill(index == viewModel.currentIndex ? Color.blue : Color.gray.opacity(0.3))
                                .frame(width: index == viewModel.currentIndex ? 16 : 8, height: index == viewModel.currentIndex ? 16 : 8)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.currentIndex = index
                                    }
                                }
                        }
                        Spacer()
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let widthPerIndex = UIScreen.main.bounds.width / CGFloat(viewModel.imageCount)
                                let newIndex = Int((value.location.x - widthPerIndex / 2) / widthPerIndex)
                                viewModel.currentIndex = max(0, min(viewModel.imageCount - 1, newIndex))
                            }
                    )
                }
                .padding(.horizontal, 30)

                HStack {
                    Text("Less")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    Spacer()
                    Text("More")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 30)
                .padding(.top, 5)
            }
            .padding(.bottom, 30)

            Spacer()

            Button(action: {
                let generator = UIImpactFeedbackGenerator(style: .medium) // Vibración de impacto
                generator.impactOccurred() // Genera la vibración
                navigateToNextView = true
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
            .padding(.bottom, 20)

            NavigationLink(destination: LevelActivityView(progressViewModel: progressViewModel), isActive: $navigateToNextView) {
                EmptyView()
            }
        }
        .background(Color(red: 249 / 255, green: 249 / 255, blue: 253 / 255).ignoresSafeArea())
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue) // Cambié el color de la flecha a azul
                }
            }
        }
    }
}

struct HowOftenView_Previews: PreviewProvider {
    static var previews: some View {
        HowOftenView(viewModel: HowOftenViewModel(), progressViewModel: ProgressViewModel()) // Pasamos el progressViewModel
    }
}

