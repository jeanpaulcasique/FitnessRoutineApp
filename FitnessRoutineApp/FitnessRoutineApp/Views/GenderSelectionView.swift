import SwiftUI

struct GenderSelectionView: View {
    @ObservedObject var viewModel: GenderSelectionViewModel
    @ObservedObject var progressViewModel: ProgressViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToGoal = false
    @State private var isLoading = false
    @State private var isButtonDisabled = false
    
    
    var body: some View {
        ZStack {
            VStack {
                ProgressBarView(progressViewModel: progressViewModel)
                    .padding(.top, 20)
                    .padding(.horizontal)
                    .opacity(viewModel.progressUpdating ? 0.5 : 1.0)

                Text("What's your gender?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 0)

                genderSelectionCards
                    .padding(.top, 150)
                    .padding()

                Spacer()

                if viewModel.selectedGender != nil {
                   
                        NextButton(
                            title: "Next",
                            action: proceedToNext,
                            isLoading: $isLoading,
                            isDisabled: $isButtonDisabled
                    )
                    .padding(.horizontal, 20)

                    NavigationLink(
                        destination: GoalView(viewModel: GoalViewModel(), progressViewModel: progressViewModel),
                        isActive: $viewModel.navigateToGoal
                    ) {
                        EmptyView()
                    }
                    .hidden()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .background(Color(red: 249/255, green: 249/255, blue: 253/255))
            
            GenderInfoView(showInfo: $viewModel.showInfo)
                .padding()
                .zIndex(1)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: goBack) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                }
            }
        }
    }

    private var genderSelectionCards: some View {
        HStack(spacing: 37) {
            GenderSelectionCard(gender: .male, isSelected: viewModel.selectedGender == .male) {
                viewModel.selectGender(.male)
            }
            GenderSelectionCard(gender: .female, isSelected: viewModel.selectedGender == .female) {
                viewModel.selectGender(.female)
            }
        }
    }

    private func proceedToNext() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        progressViewModel.advanceProgress()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.viewModel.navigateToGoal = true
        }
    }

    private func goBack() {
        progressViewModel.decreaseProgress()
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - GenderInfoView
struct GenderInfoView: View {
    @Binding var showInfo: Bool

    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "info.circle")
                    .foregroundColor(.blue)
                    .font(.title)
                    .padding(.top, -290)
                    .onTapGesture { withAnimation { showInfo.toggle() } }
                Text("Why we ask this?")
                    .font(.headline)
                    .padding(.top, -285)
                    .foregroundColor(.blue)
                    .onTapGesture { withAnimation { showInfo.toggle() } }
                Spacer()
            }
            .padding(.horizontal)

            if showInfo {
                Text("This will help us tailor your workout to match your metabolic rate perfectly.")
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .transition(.opacity)
                    .padding(.horizontal)
                    .padding(.top, -290)
                    .zIndex(1)
                    .offset(y: 50)
            }
        }
    }
}

// MARK: - GenderSelectionCard
struct GenderSelectionCard: View {
    let gender: Gender
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        ZStack {
            Button(action: action) {
                Image(gender == .male ? "male" : "female")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 275)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
                    )
            }
            .scaleEffect(isSelected ? 1.05 : 1.0)
            .shadow(color: isSelected ? Color.blue.opacity(0.5) : Color.clear, radius: 10, x: 0, y: 5)

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
                    .offset(x: 55, y: -120)
            }
        }
    }
}

// MARK: - Preview
struct GenderSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectionView(viewModel: GenderSelectionViewModel(), progressViewModel: ProgressViewModel())
    }
}

