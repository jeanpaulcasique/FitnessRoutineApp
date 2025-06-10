import SwiftUI
import Combine

// MARK: - Epic DietTypeView
struct DietTypeView: View {
    @StateObject private var viewModel = DietTypeViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToNextView = false
    @Environment(\.presentationMode) var presentationMode
    @State private var showDietInfo = false
    @State private var selectedDietForInfo: DietDetails?
    @State private var showCardsAnimation = false
    @State private var showHeaderAnimation = false
    @State private var isLoading = false
    @State private var shownInfoForIndices: Set<Int> = []
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            backgroundGradient
            
            ScrollView {
                VStack(spacing: 28) {
                    progressSection
                    headerSection
                    dietCardsSection
                    pageIndicator
                    quickComparisonSection
                    
                    Spacer(minLength: 80)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
            }
            
            nextButtonOverlay
        }
        .navigationTitle("Diet Type")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onAppear {
            setupAnimations()
            viewModel.checkConnectivity()
        }
        .sheet(isPresented: $showDietInfo) {
            if let dietDetails = selectedDietForInfo {
                EpicDietInfoView(dietDetails: dietDetails)
            }
        }
        .alert(isPresented: $viewModel.isOffline) {
            Alert(
                title: Text("Offline Mode"),
                message: Text("You're currently offline. Some features may be limited."),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    var pageIndicator: some View {
        HStack(spacing: 8) {
            ForEach(0..<viewModel.imageCount, id: \.self) { index in
                Circle()
                    .fill(index == viewModel.currentIndex ? Color.appYellow : Color.gray)
                    .frame(width: 8, height: 8)
                    .animation(.spring(), value: viewModel.currentIndex)
                    .accessibilityLabel("Page \(index + 1) of \(viewModel.imageCount)")
                    .accessibilityAddTraits(index == viewModel.currentIndex ? .isSelected : [])
            }
        }
        .padding(.top, 16)
    }
}

// MARK: - Background & Navigation
private extension DietTypeView {
    var backgroundGradient: some View {
        LinearGradient(
            colors: [Color.appBlack, Color.gray.opacity(0.3), Color.appBlack],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .accessibilityHidden(true)
    }
    
    var backButton: some View {
        Button(action: {
            progressViewModel.decreaseProgress()
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.appYellow)
                .font(.system(size: 18))
        }
        .accessibilityLabel("Go back")
    }
    
    var nextButtonOverlay: some View {
        VStack {
            Spacer()
            VStack {
                NextButton(
                    title: isLoading ? "Loading..." : "Next",
                    action: {
                        withAnimation {
                            isLoading = true
                        }
                        proceedToNext()
                    },
                    isLoading: $isLoading,
                    isDisabled: $viewModel.isNextButtonDisabled
                )
                
                NavigationLink(
                    destination: LevelActivityView(progressViewModel: progressViewModel),
                    isActive: $navigateToNextView
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .padding(.horizontal, 0)
            .padding(.bottom, 0)
        }
    }
}

// MARK: - Main Sections
private extension DietTypeView {
    var progressSection: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Setup Progress")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.appWhite.opacity(0.7))
                Spacer()
                Text("\(Int(progressViewModel.progress * 100))%")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.appYellow)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Setup Progress: \(Int(progressViewModel.progress * 100))%")
            
            ProgressBarView(progressViewModel: progressViewModel)
                .accessibilityHidden(true)
        }
        .padding(.top, 20)
    }
    
    var headerSection: some View {
        VStack(spacing: 16) {
            if showHeaderAnimation {
                dietIcon
                headerText
            }
        }
        .padding(.top, 15)
    }
    
    var dietIcon: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.appYellow.opacity(0.4), Color.appYellow.opacity(0.1)],
                        center: .center,
                        startRadius: 30,
                        endRadius: 70
                    )
                )
                .frame(width: 120, height: 120)
                .accessibilityHidden(true)
            
            Image(systemName: "fork.knife.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.appYellow)
                .accessibilityLabel("Diet Selection Icon")
        }
        .transition(.scale.combined(with: .opacity))
    }
    
    var headerText: some View {
        VStack(spacing: 12) {
            Text("Which diet suits your goal?")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.appYellow)
                .multilineTextAlignment(.center)
            
            Text("Choose the approach that fits your lifestyle and preferences")
                .font(.system(size: 16))
                .foregroundColor(.appWhite.opacity(0.8))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
        .transition(.move(edge: .top).combined(with: .opacity))
        .accessibilityElement(children: .combine)
    }
    
    var dietCardsSection: some View {
        VStack(spacing: 20) {
            if showCardsAnimation {
                HStack {
                    Text("Select Your Diet")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.appYellow)
                        .help("Choose the diet that best matches your goals and lifestyle")
                    
                    Spacer()
                    
                    Text("Tap for details")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.appWhite.opacity(0.7))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .help("Tap on any diet card to see more information")
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0..<viewModel.imageCount, id: \.self) { index in
                            EpicDietCard(
                                imageName: viewModel.imageNames[index],
                                title: viewModel.titles[index],
                                shortDescription: viewModel.shortDescriptions[index],
                                detailedDescription: viewModel.detailedDescriptions[index],
                                isSelected: index == viewModel.currentIndex,
                                dietDetails: viewModel.getDietDetails(for: index)
                            )
                            .frame(width: 260, height: 340)
                            .onTapGesture {
                                handleDietSelection(index)
                            }
                            .gesture(
                                DragGesture()
                                    .onEnded { value in
                                        if abs(value.translation.width) > 50 {
                                            let direction = value.translation.width > 0 ? -1 : 1
                                            let newIndex = (viewModel.currentIndex + direction + viewModel.imageCount) % viewModel.imageCount
                                            handleDietSelection(newIndex)
                                        }
                                    }
                            )
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("\(viewModel.titles[index]) Diet")
                            .accessibilityHint("Double tap to select this diet type")
                            .accessibilityAddTraits(index == viewModel.currentIndex ? .isSelected : [])
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .transition(.move(edge: .leading).combined(with: .opacity))
            }
        }
    }
    
    var quickComparisonSection: some View {
        VStack(spacing: 16) {
            if showCardsAnimation {
                LazyVStack(spacing: 12) {
                    HStack {
                        Text("Quick Comparison")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.appYellow)
                        Spacer()
                    }
                    .accessibilityAddTraits(.isHeader)
                    
                    QuickComparisonCard(viewModel: viewModel)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}

private extension DietTypeView {
    func setupAnimations() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.2)) {
            showHeaderAnimation = true
        }
        
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.8)) {
            showCardsAnimation = true
        }
    }
    
    func handleDietSelection(_ index: Int) {
        let wasNewSelection = viewModel.currentIndex != index
        
        // Feedback táctil diferenciado
        if wasNewSelection {
            let heavyFeedback = UIImpactFeedbackGenerator(style: .heavy)
            heavyFeedback.impactOccurred()
        } else {
            let lightFeedback = UIImpactFeedbackGenerator(style: .light)
            lightFeedback.impactOccurred()
        }
        
        viewModel.selectDiet(index)
        
        let shouldShowInfo = wasNewSelection || !shownInfoForIndices.contains(index)
        
        if shouldShowInfo {
            if let details = viewModel.getDietDetails(for: index) {
                selectedDietForInfo = details
                showDietInfo = true
                shownInfoForIndices.insert(index)
            }
        }
    }
    
    func proceedToNext() {
        viewModel.disableNextButtonTemporarily()
        
        withAnimation(.easeInOut(duration: 0.5)) {
            progressViewModel.advanceProgress()
        }
        
        let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedback.impactOccurred()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            navigateToNextView = true
            isLoading = false
        }
    }
}
// ... rest of the existing code ... 