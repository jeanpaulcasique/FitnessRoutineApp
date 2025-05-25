import SwiftUI

// MARK: - DietTypeView
struct DietTypeView: View {
    @StateObject private var viewModel = DietTypeViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToNextView = false
    @Environment(\.presentationMode) var presentationMode
    @State private var isButtonDisabled = false
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 20) {
            // Progress bar
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)

            // Question
            Text("Which type of diet suits your goal?")
                .font(.system(size: 26, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal)

            // Diet options as cards
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 24) {
                    ForEach(0..<viewModel.imageCount, id: \.self) { idx in
                        DietCard(
                            imageName: viewModel.imageNames[idx],
                            title: viewModel.titles[idx],
                            description: viewModel.longDescriptions[idx],
                            isSelected: idx == viewModel.currentIndex
                        )
                        .frame(width: 220, height: 300)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                viewModel.currentIndex = idx
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }

            Spacer()

            // Next button
            NextButton(
                title: "Next",
                action: proceedToNext,
                isLoading: $isLoading,
                isDisabled: $isButtonDisabled
        )
            .padding(.horizontal, 0)
            .padding(.bottom, -20)

            NavigationLink(
                destination: LevelActivityView(progressViewModel: progressViewModel),
                isActive: $navigateToNextView
            ) {
                EmptyView()
            }
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: goBack) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                }
            }
        }
    }

    private func proceedToNext() {
        viewModel.disableNextButtonTemporarily()
        withAnimation(.easeInOut) {
            progressViewModel.advanceProgress()
        }
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            navigateToNextView = true
        }
    }

    private func goBack() {
        progressViewModel.decreaseProgress()
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - DietCard
struct DietCard: View {
    let imageName: String
    let title: String
    let description: String
    let isSelected: Bool

    var body: some View {
        ZStack(alignment: .bottom) {
            // Background gradient
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: isSelected ? [Color.blue.opacity(0.8), Color.purple.opacity(0.8)] : [Color.white, Color.white]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: Color.black.opacity(isSelected ? 0.3 : 0.1), radius: isSelected ? 12 : 6, x: 0, y: 6)

            VStack(spacing: 12) {
                // Diet Image in circle
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.5))
                        .frame(width: 80, height: 80)
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(isSelected ? .white : .blue)
                }
                .padding(.top, 24)

                // Title
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(isSelected ? .white : .primary)

                // Description (short)
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(isSelected ? .white.opacity(0.9) : .secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)

                Spacer()
            }
            .padding(.bottom, 24)
        }
        .scaleEffect(isSelected ? 1.1 : 0.95)
        .animation(.spring(), value: isSelected)
    }
}

// MARK: - Preview
struct DietTypeView_Previews: PreviewProvider {
    static var previews: some View {
        DietTypeView(progressViewModel: ProgressViewModel())
            .preferredColorScheme(.light)

        DietTypeView(progressViewModel: ProgressViewModel())
            .preferredColorScheme(.dark)
    }
}
