import SwiftUI
import UIKit

// MARK: - HeightView
struct HeightView: View {
    @StateObject var viewModel = HeightViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToWeightView = false
    @State private var isNextButtonDisabled = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            progressBar
            titleView
            Spacer()
            unitSelector
            heightPicker
            Spacer()
            nextButton
            navigationLink
        }
        .background(backgroundColor)
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar { backButton }
        .onAppear {
            viewModel.loadHeightFromUserDefaults()
        }
    }
}

// MARK: - Subviews & Helpers
private extension HeightView {
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
            .foregroundColor(.black)
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
                Text("ft/in")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(!viewModel.isCmSelected ? .white : .black)
                    .padding()
                    .background(!viewModel.isCmSelected ? Color.black : Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 40)
    }
    
    var heightPicker: some View {
        Picker("Select Height", selection: viewModel.isCmSelected ? $viewModel.selectedHeightCm : $viewModel.selectedHeightFt) {
            if viewModel.isCmSelected {
                ForEach(100...230, id: \..self) { height in
                    Text("\(height) cm")
                        .tag(height)
                        .foregroundColor(viewModel.selectedHeightCm == height ? .blue : .black)
                }
            } else {
                ForEach(3...7, id: \..self) { feet in
                    ForEach(0...11, id: \..self) { inch in
                        Text("\(feet) ft \(inch) in")
                            .tag(feet * 12 + inch)
                            .foregroundColor(viewModel.selectedHeightFt == feet * 12 + inch ? .blue : .black)
                    }
                }
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(height: 250)
        .clipped()
        .padding(.horizontal, 16)
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
        .disabled(isNextButtonDisabled)
        .simultaneousGesture(TapGesture().onEnded {
            generateHapticFeedback()
        })
    }
    
    var navigationLink: some View {
        NavigationLink(
            destination: WeightView(
                progressViewModel: progressViewModel,
                userHeight: viewModel.isCmSelected ?
                    Double(viewModel.selectedHeightCm) :
                    Double(viewModel.selectedHeightFt) * 2.54
            ),
            isActive: $navigateToWeightView
        ) {
            EmptyView()
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
    
    func proceedToNext() {
        isNextButtonDisabled = true
        withAnimation(.easeInOut(duration: 0.5)) {
            progressViewModel.advanceProgress()
        }
        generateHapticFeedback()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigateToWeightView = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isNextButtonDisabled = false
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

struct HeightView_Previews: PreviewProvider {
    static var previews: some View {
        HeightView(progressViewModel: ProgressViewModel())
    }
}

