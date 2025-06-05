import SwiftUI

// MARK: - DietTypeView
struct DietTypeView: View {
    @StateObject private var viewModel = DietTypeViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var navigateToNextView = false
    @Environment(\.presentationMode) var presentationMode
    @State private var isButtonDisabled = false
    @State private var isLoading = false
    @State private var showDietInfo = false
    @State private var selectedDietForInfo: DietInfo?

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
                .foregroundColor(.yellow)
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
                                let wasNewSelection = viewModel.currentIndex != idx
                                viewModel.currentIndex = idx
                                
                                // Mostrar información solo si es nueva selección y no se ha mostrado antes
                                if wasNewSelection && !viewModel.hasShownInfoFor(index: idx) {
                                    selectedDietForInfo = viewModel.getDietInfo(for: idx)
                                    showDietInfo = true
                                    viewModel.markInfoAsShown(for: idx)
                                }
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
        .background(Color.black.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: goBack) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.yellow)
                }
            }
        }
        .sheet(isPresented: $showDietInfo) {
            if let dietInfo = selectedDietForInfo {
                DietInfoView(dietInfo: dietInfo)
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
                        gradient: Gradient(colors: isSelected ? [Color.yellow.opacity(0.8), Color.yellow.opacity(0.6)] : [Color(.darkGray), Color(.black)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: Color.black.opacity(isSelected ? 0.3 : 0.1), radius: isSelected ? 12 : 6, x: 0, y: 6)

            VStack(spacing: 12) {
                // Diet Image in circle
                ZStack {
                    Circle()
                        .fill(isSelected ? Color.yellow.opacity(0.5) : Color.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(isSelected ? .black : .yellow)
                }
                .padding(.top, 24)

                // Title
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(isSelected ? Color.yellow : Color.white)

                // Description (short)
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(isSelected ? Color.yellow.opacity(0.9) : Color.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)

                Spacer()
            }
            .padding(.bottom, 24)
        }
        .scaleEffect(isSelected ? 1.01 : 0.95)
        .animation(.spring(), value: isSelected)
    }
}

// MARK: - Diet Info Model
struct DietInfo: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let howItWorks: String
    let benefits: [String]
    let considerations: [String]
    let color: Color
    let icon: String
}

// MARK: - DietInfoView
struct DietInfoView: View {
    let dietInfo: DietInfo
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header con icono
                    HStack {
                        ZStack {
                            Circle()
                                .fill(dietInfo.color.opacity(0.2))
                                .frame(width: 60, height: 60)
                            
                            Image(systemName: dietInfo.icon)
                                .font(.system(size: 28))
                                .foregroundColor(dietInfo.color)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(dietInfo.title)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.yellow)
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    
                    // Descripción
                    Text(dietInfo.description)
                        .font(.system(size: 16))
                        .foregroundColor(Color.white.opacity(0.9))
                        .lineSpacing(4)
                    
                    // Cómo funciona
                    VStack(alignment: .leading, spacing: 10) {
                        Text("How it works")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.yellow)
                        
                        Text(dietInfo.howItWorks)
                            .font(.system(size: 15))
                            .foregroundColor(Color.white.opacity(0.8))
                            .lineSpacing(4)
                    }
                    
                    // Beneficios
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Key Benefits")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.yellow)
                        
                        ForEach(dietInfo.benefits, id: \.self) { benefit in
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.system(size: 16))
                                    .padding(.top, 2)
                                
                                Text(benefit)
                                    .font(.system(size: 15))
                                    .foregroundColor(Color.white.opacity(0.8))
                                    .lineSpacing(3)
                                
                                Spacer()
                            }
                        }
                    }
                    
                    // Consideraciones
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Important Considerations")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.yellow)
                        
                        ForEach(dietInfo.considerations, id: \.self) { consideration in
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: "info.circle.fill")
                                    .foregroundColor(.orange)
                                    .font(.system(size: 16))
                                    .padding(.top, 2)
                                
                                Text(consideration)
                                    .font(.system(size: 15))
                                    .foregroundColor(Color.white.opacity(0.8))
                                    .lineSpacing(3)
                                
                                Spacer()
                            }
                        }
                    }
                    
                    Spacer(minLength: 30)
                }
                .padding(20)
            }
            .background(Color.black)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Got it!") {
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.yellow)
            .font(.system(size: 16, weight: .semibold)))
        }
    }
}

// MARK: - Preview
struct DietTypeView_Previews: PreviewProvider {
    static var previews: some View {
        DietTypeView(progressViewModel: ProgressViewModel())
    }
}
