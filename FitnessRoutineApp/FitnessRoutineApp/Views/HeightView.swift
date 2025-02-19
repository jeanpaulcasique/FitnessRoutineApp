import SwiftUI
import UIKit

// MARK: - HeightView
struct HeightView: View {
    @StateObject  var viewModel = HeightViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToWeightView = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        HStack(spacing: 0) {
            mainContent
            measurementRuler
        }
        .background(backgroundColor)
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar { backButton }
    }
}

// MARK: - Subviews & Helpers
private extension HeightView {
    var mainContent: some View {
        VStack {
            progressBar
            titleView
            unitSelector
            selectedHeightDisplay
            Spacer()
            nextButton
            // Navegación oculta a WeightView
            NavigationLink(
                destination: WeightView(
                    progressViewModel: progressViewModel,
                    userHeight: viewModel.isCmSelected ?
                        Double(viewModel.selectedHeightCm) :
                        Double(viewModel.selectedHeightFt) * 30.48
                ),
                isActive: $navigateToWeightView
            ) {
                EmptyView()
            }
        }
    }
    
    var progressBar: some View {
        ProgressBarView(progressViewModel: progressViewModel)
            .padding(.top, 120)
            .padding(.horizontal, 20)
    }
    
    var titleView: some View {
        Text("What's your height?")
            .font(.title)
            .fontWeight(.bold)
            .padding(.top, 20)
            .padding(.horizontal, 10)
            .lineLimit(1)
            .foregroundColor(.black)
            .padding(.bottom, 180)
    }
    
    var unitSelector: some View {
        HStack {
            Button(action: { viewModel.toggleUnit(toCm: true) }) {
                Text("cm")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(viewModel.isCmSelected ? .white : .black)
                    .padding()
                    .background(viewModel.isCmSelected ? Color.black : Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            Button(action: { viewModel.toggleUnit(toCm: false) }) {
                Text("ft")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(!viewModel.isCmSelected ? .white : .black)
                    .padding()
                    .background(!viewModel.isCmSelected ? Color.black : Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 40)
    }
    
    var selectedHeightDisplay: some View {
        Group {
            if viewModel.isCmSelected {
                Text("\(viewModel.selectedHeightCm) cm")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.blue)
            } else {
                Text("\(viewModel.selectedHeightFt) ft \(viewModel.selectedHeightInch) in")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.blue)
            }
        }
    }
    
    var nextButton: some View {
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
        .padding(.bottom, 30)
        .simultaneousGesture(TapGesture().onEnded {
            generateHapticFeedback()
        })
    }
    
    var measurementRuler: some View {
        VStack {
            Spacer()
            VStack(spacing: 15) {
                ForEach(getHeightRange(), id: \.self) { height in
                    Text(viewModel.isCmSelected ?
                         "\(height) cm" :
                         "\(height / 12) ft \(height % 12) in")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .offset(y: calculateOffset(for: height))
                }
            }
            .frame(width: 60, height: 300)
            .background(Color.white)
            .border(Color.black)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let threshold: CGFloat = 20
                        if value.translation.height < -threshold {
                            if viewModel.isCmSelected {
                                viewModel.updateHeightInCm(Double(viewModel.selectedHeightCm + 1))
                            } else {
                                viewModel.incrementFeetAndInches()
                            }
                        } else if value.translation.height > threshold {
                            if viewModel.isCmSelected {
                                viewModel.updateHeightInCm(Double(viewModel.selectedHeightCm - 1))
                            } else {
                                viewModel.decrementFeetAndInches()
                            }
                        }
                    }
            )
            Spacer()
        }
        .padding(.trailing, 10)
    }
    
    func getHeightRange() -> [Int] {
        if viewModel.isCmSelected {
            return Array(100...230).reversed()
        } else {
            return Array(40...98)
        }
    }
    
    func calculateOffset(for height: Int) -> CGFloat {
        if viewModel.isCmSelected {
            return CGFloat(viewModel.selectedHeightCm - height) * 3
        } else {
            let totalInches = (viewModel.selectedHeightFt * 12) + viewModel.selectedHeightInch
            return CGFloat(totalInches - height) * -10
        }
    }
    
    var backgroundColor: Color {
        Color(red: 249/255, green: 249/255, blue: 253/255)
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
    
    // Acción para avanzar: actualiza la barra de progreso con animación y, tras un retraso, navega a WeightView
    func proceedToNext() {
        withAnimation(.easeInOut(duration: 0.5)) {
            progressViewModel.advanceProgress()
        }
        generateHapticFeedback()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigateToWeightView = true
        }
    }
    
    // Acción para retroceder: disminuye la barra de progreso y retrocede
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
struct HeightView_Previews: PreviewProvider {
    static var previews: some View {
        HeightView(progressViewModel: ProgressViewModel())
    }
}

