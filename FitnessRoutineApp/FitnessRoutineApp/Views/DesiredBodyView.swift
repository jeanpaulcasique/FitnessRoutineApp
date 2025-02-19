import SwiftUI
import UIKit

// MARK: - DesiredBodyView
struct DesiredBodyView: View {
    @StateObject var viewModel = DesiredBodyViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var isNavigatingToBirthYearView = false
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            
            // Título
            Text("What's your desired body shape?")
                .font(.system(size: 31, weight: .bold))
                .padding(.top, 10)
                .foregroundColor(.black)
                .padding(.horizontal, 10)
            
            // TabView para seleccionar imagen de cuerpo
            bodyImageSelector
                .padding(.vertical, 10)
            
            // Slider e indicadores
            sliderIndicator
            
            // Labels debajo del slider
            labelsBelowSlider
            
            // Información sobre la grasa corporal
            infoView
            
            // NavigationLink para ir a BirthYearView (oculto)
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
            .simultaneousGesture(TapGesture().onEnded {
                // Solo se genera feedback háptico al pulsar el botón Next
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
                ForEach(0..<viewModel.bodyImages.count, id: \.self) { index in
                    bodyImageView(for: index, geometry: geometry)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(width: geometry.size.width, height: 320)
            .clipped()
            .onChange(of: viewModel.selectedBodyIndex) { _ in
                // Aquí no se actualiza el progreso, solo se genera feedback
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
        let offset = viewModel.selectedBodyIndex == index ? 0 : -20
        return image
            .opacity(opacity)
            .scaleEffect(scale)
            .offset(x: CGFloat(offset))
            .animation(.easeInOut(duration: 0.4), value: viewModel.selectedBodyIndex)
    }
    
    var sliderIndicator: some View {
        ZStack {
            HStack(spacing: 30) {
                ForEach(0..<viewModel.bodyImages.count, id: \.self) { index in
                    Circle()
                        .fill(index == viewModel.selectedBodyIndex ? Color.blue : Color.blue.opacity(0.3))
                        .frame(width: index == viewModel.selectedBodyIndex ? 20 : 12,
                               height: index == viewModel.selectedBodyIndex ? 20 : 12)
                        .animation(.easeInOut(duration: 0.2), value: viewModel.selectedBodyIndex)
                }
            }
            .frame(height: 20)
            .padding(.horizontal, 40)
            
            Slider(value: Binding(
                get: { Double(viewModel.selectedBodyIndex) },
                set: { newValue in
                    viewModel.selectedBodyIndex = Int(newValue)
                    viewModel.selectBody(index: viewModel.selectedBodyIndex)
                    generateHapticFeedback()
                }
            ), in: 0...Double(viewModel.bodyImages.count - 1), step: 1)
            .opacity(0.01)
        }
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
                .foregroundColor(viewModel.bodyFatRanges[viewModel.selectedBodyIndex].contains("Consult a doctor") ? .red : .green)
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
    
    // Acción para avanzar: se ejecuta únicamente al presionar el botón "Next"
    func proceedToNext() {
        // Generar feedback háptico y actualizar la barra de progreso con animación
        withAnimation(.easeInOut(duration: 0.5)) {
            progressViewModel.advanceProgress()
        }
        generateHapticFeedback()
        // Retraso para permitir que la animación se muestre antes de navegar
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isNavigatingToBirthYearView = true
        }
    }
    
    // Acción para retroceder y actualizar la barra de progreso
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

