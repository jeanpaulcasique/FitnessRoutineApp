import SwiftUI
import UIKit

struct HeightView: View {
    @StateObject var viewModel = HeightViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToWeightView = false
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
            .foregroundColor(.yellow)
    }

    var unitSelector: some View {
        HStack {
            Button(action: { viewModel.toggleUnit(toCm: true) }) {
                Text("cm")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(viewModel.isCmSelected ? .black : .white)
                    .padding()
                    .background(viewModel.isCmSelected ? Color.yellow : Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            Button(action: { viewModel.toggleUnit(toCm: false) }) {
                Text("ft/in")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(!viewModel.isCmSelected ? .black : .white)
                    .padding()
                    .background(!viewModel.isCmSelected ? Color.yellow : Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 40)
    }

    var heightPicker: some View {
        Picker("Select Height", selection: viewModel.isCmSelected ? $viewModel.selectedHeightCm : $viewModel.selectedHeightFt) {
            if viewModel.isCmSelected {
                ForEach(100...230, id: \.self) { height in
                    Text("\(height) cm")
                        .tag(height)
                        .foregroundColor(viewModel.selectedHeightCm == height ? .yellow : .white)
                }
            } else {
                ForEach(3...7, id: \.self) { feet in
                    ForEach(0...11, id: \.self) { inch in
                        Text("\(feet) ft \(inch) in")
                            .tag(feet * 12 + inch)
                            .foregroundColor(viewModel.selectedHeightFt * 12 + viewModel.selectedHeightInch == feet * 12 + inch ? .yellow : .white)
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
        NextButton(
            title: "Next",
            action: proceedToNext,
            isLoading: $viewModel.isLoading,
            isDisabled: $viewModel.isButtonDisabled
        )
        .padding(.bottom, 30)
    }

    var navigationLink: some View {
        NavigationLink(
            destination: WeightView(
                progressViewModel: progressViewModel,
                userHeight: viewModel.isCmSelected ?
                    Double(viewModel.selectedHeightCm) :
                    Double(viewModel.selectedHeightFt * 12 + viewModel.selectedHeightInch) * 2.54
            ),
            isActive: $navigateToWeightView
        ) {
            EmptyView()
        }
    }

    var backgroundColor: Color {
        Color.black
    }

    var backButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: goBack) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.yellow)
                    .imageScale(.large)
            }
        }
    }

    func proceedToNext() {
        generateHapticFeedback()
        withAnimation(.easeInOut(duration: 0.5)) {
            progressViewModel.advanceProgress()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigateToWeightView = true
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
