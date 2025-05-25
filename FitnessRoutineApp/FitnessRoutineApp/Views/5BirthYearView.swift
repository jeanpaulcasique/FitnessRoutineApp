import SwiftUI
import UIKit
import Combine

// MARK: - BirthYearView
struct BirthYearView: View {
    @StateObject var viewModel: BirthYearViewModel
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var isNavigatingToNextScreen = false
    @State private var isLoading = false
    @State private var isDisabled = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            progressBar
            title
            descriptionText
            birthYearPicker
            showInfo
            Spacer()
            nextButton
            navigationLink
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar { backButton }
        .background(backgroundColor)
        .onAppear {
            viewModel.selectedYear = UserDefaults.standard.integer(forKey: "selectedBirthYear")
        }
    }
}

// MARK: - Subviews & Helpers
private extension BirthYearView {
    var progressBar: some View {
        ProgressBarView(progressViewModel: progressViewModel)
            .padding(.top, 20)
            .padding(.horizontal, 20)
    }
    
    var title: some View {
        Text("What's your birth year?")
            .font(.title)
            .fontWeight(.bold)
            .padding(.top, 20)
            .foregroundColor(.black)
    }
    
    var descriptionText: some View {
        Text("This will help us tailor workouts to suit your body's capabilities and ensure safe training.")
            .font(.body)
            .foregroundColor(.gray)
            .padding(.horizontal, 30)
            .padding(.top, 10)
            .multilineTextAlignment(.center)
    }
    
    var birthYearPicker: some View {
        Picker("Select your birth year", selection: $viewModel.selectedYear) {
            ForEach(1900..<Calendar.current.component(.year, from: Date()) + 1, id: \.self) { year in
                Text(String(year))
                    .font(.system(size: viewModel.selectedYear == year ? 36 : 24, weight: .bold))
                    .foregroundColor(viewModel.selectedYear == year ? .blue : .gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                    .scaleEffect(viewModel.selectedYear == year ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: viewModel.selectedYear)
                    .tag(year)
                    .onChange(of: viewModel.selectedYear) { _ in
                        vibrate()
                        UserDefaults.standard.set(viewModel.selectedYear, forKey: "selectedBirthYear")
                    }
            }
        }
        .pickerStyle(WheelPickerStyle())
        .background(Color.clear)
        .frame(height: 350)
        .clipped()
        .padding(.horizontal, 16)
    }
    
    var showInfo: some View {
        Text("Selected Birth Year: \(viewModel.selectedYear)")
            .font(.title2)
            .padding()
            .foregroundColor(.black)
            .opacity(0)
    }
    
    var nextButton: some View {
        NextButton(
            title: "Next",
            action: {
                withAnimation {
                    progressViewModel.advanceProgress()
                }
                vibrate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.isNavigatingToNextScreen = true
                }
            },
            isLoading: $isLoading,
            isDisabled: $isDisabled
        )
    }
    
    var navigationLink: some View {
        NavigationLink(
            destination: HeightView(viewModel: HeightViewModel(), progressViewModel: progressViewModel),
            isActive: $isNavigatingToNextScreen
        ) {
            EmptyView()
        }
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
    
    var backgroundColor: Color {
        Color(red: 249/255, green: 249/255, blue: 253/255)
    }
    
    func goBack() {
        progressViewModel.decreaseProgress()
        presentationMode.wrappedValue.dismiss()
    }
    
    func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

// MARK: - Preview
struct BirthYearView_Previews: PreviewProvider {
    static var previews: some View {
        BirthYearView(viewModel: BirthYearViewModel(), progressViewModel: ProgressViewModel())
    }
}

