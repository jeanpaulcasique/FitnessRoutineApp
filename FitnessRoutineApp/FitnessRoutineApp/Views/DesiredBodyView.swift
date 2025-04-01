import SwiftUI

// MARK: - DesiredBodyView
struct DesiredBodyView: View {
    @StateObject var viewModel = DesiredBodyViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var isNavigatingToBirthYearView = false
    @State private var isNextButtonDisabled = false
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            
            // Título
            Text("What's your desired body shape?")
                .font(.system(size: 29, weight: .bold))
                .padding(.top, 10)
                .foregroundColor(.black)
                .padding(.horizontal, 10)
            
            // Selector de imágenes de cuerpo
            bodyImageSelector
                .padding(.vertical, 10)
            
            // Slider e indicadores
            sliderIndicator
            
            // Labels debajo del slider
            labelsBelowSlider
            
            // Información sobre la grasa corporal
            infoView
            
            // Navegación oculta a BirthYearView
            NavigationLink(
                destination: BirthYearView(viewModel: BirthYearViewModel(), progressViewModel: progressViewModel),
                isActive: $isNavigatingToBirthYearView
            ) {
                EmptyView()
            }
            
            // Botón "Next"
            Button(action: proceedToNext) {
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
            .disabled(isNextButtonDisabled)
            .simultaneousGesture(TapGesture().onEnded {
                generateHapticFeedback()
            })
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar { backButton }
        .background(Color(red: 249/255, green: 249/255, blue: 253/255))
    }
}

// MARK: - Subviews & Helpers
private extension DesiredBodyView {
    var bodyImageSelector: some View {
        GeometryReader { geometry in
            TabView(selection: $viewModel.selectedBodyIndex) {
                ForEach(0..<viewModel.bodyImages.count, id: \..self) { index in
                    bodyImageView(for: index, geometry: geometry)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(width: geometry.size.width, height: 320)
            .clipped()
            .onChange(of: viewModel.selectedBodyIndex) { newValue in
                generateHapticFeedback()
            }
        }
    }
    
    func bodyImageView(for index: Int, geometry: GeometryProxy) -> some View {
        let image = Image(viewModel.bodyImages[index])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: geometry.size.width * 0.65)
        let opacity = viewModel.selectedBodyIndex == index ? 1.0 : 0.5
        let scale = viewModel.selectedBodyIndex == index ? 1.1 : 0.9
        return image
            .opacity(opacity)
            .scaleEffect(scale)
            .animation(.easeInOut(duration: 0.4), value: viewModel.selectedBodyIndex)
    }
    
    var sliderIndicator: some View {
        HStack(spacing: 30) {
            ForEach(0..<viewModel.bodyImages.count, id: \..self) { index in
                Circle()
                    .fill(index == viewModel.selectedBodyIndex ? Color.blue : Color.blue.opacity(0.3))
                    .frame(width: index == viewModel.selectedBodyIndex ? 20 : 12,
                           height: index == viewModel.selectedBodyIndex ? 20 : 12)
                    .animation(.easeInOut(duration: 0.2), value: viewModel.selectedBodyIndex)
            }
        }
        .frame(height: 20)
        .padding(.horizontal, 40)
    }
    
    var labelsBelowSlider: some View {
        HStack {
            Text("Cut")
                .font(.system(size: 16, weight: .semibold))
            Spacer()
            Text("Extra")
                .font(.system(size: 16, weight: .semibold))
        }
        .padding(.horizontal, 40)
        .padding(.top, 5)
    }
    
    var infoView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "target")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                Text("Your Target Body Fat")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
            }
            Text(viewModel.bodyFatRanges[viewModel.selectedBodyIndex])
                .font(.system(size: 16))
                .foregroundColor(.green)
            Text(viewModel.bodyFatDescriptions[viewModel.selectedBodyIndex])
                .font(.system(size: 13))
                .foregroundColor(.gray)
        }
        .padding(20)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .padding(.bottom, 15)
    }
    
    var backButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: goBack) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
                    .imageScale(.large)
            }
        }
    }
    
    func proceedToNext() {
        isNextButtonDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isNextButtonDisabled = false
        }
        
        UserDefaults.standard.set(viewModel.bodyImages[viewModel.selectedBodyIndex], forKey: "desiredBodyImage")
        
        progressViewModel.advanceProgress()
        generateHapticFeedback()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.isNavigatingToBirthYearView = true
        }
    }
    
    func goBack() {
        progressViewModel.decreaseProgress()
        presentationMode.wrappedValue.dismiss()
    }
    
    func generateHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}



// MARK: - Preview
struct DesiredBodyView_Previews: PreviewProvider {
    static var previews: some View {
        DesiredBodyView(progressViewModel: ProgressViewModel())
    }
}

