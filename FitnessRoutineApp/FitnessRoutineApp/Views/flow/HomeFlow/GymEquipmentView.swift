import SwiftUI

// MARK: - GymEquipmentView
struct GymEquipmentView: View {
    @StateObject private var viewModel = GymEquipmentViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToDashboard = false

    var body: some View {
        VStack {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)

            // Título
            Text("Do you have gym equipment?")
                .font(.system(size: 35, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .padding(.bottom, 50)

            // Botón 1: Bodyweight
            GymEquipmentButton(imageName: "gymE1", index: 0, viewModel: viewModel)

            // Botón 2: Gym Equipment -> navegar al Dashboard
            GymEquipmentButton(imageName: "gymE2", index: 1, viewModel: viewModel)

            Spacer()

            // NextButton
            NextButton(
                title: "Next",
                action: {
                    if viewModel.selectedIndex == 1 {
                        progressViewModel.advanceProgress()
                        navigateToDashboard = true
                    }
                    triggerHapticFeedback()
                },
                isLoading: .constant(false), // Si necesitas loading, conecta a un @State
                isDisabled: .constant(false)
            )
            .padding(.bottom, 30)

            // Navegación oculta a DashboardView
            NavigationLink(
                destination: DashboardView(),
                isActive: $navigateToDashboard
            ) {
                EmptyView()
            }
        }
        .background(Color(red: 249/255, green: 249/255, blue: 253/255))
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
        .toolbar { backButton }
    }

    private var backButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: goBack) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
                    .imageScale(.large)
            }
        }
    }

    private func goBack() {
        progressViewModel.decreaseProgress()
        presentationMode.wrappedValue.dismiss()
    }

    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}


// MARK: - GymEquipmentButton
struct GymEquipmentButton: View {
    let imageName: String
    let index: Int
    @ObservedObject var viewModel: GymEquipmentViewModel

    var body: some View {
        Button(action: {
            viewModel.selectOption(index)
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }) {
            ZStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                    .clipped()
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(viewModel.selectedIndex == index ? Color.blue : Color.clear,
                                    lineWidth: viewModel.selectedIndex == index ? 6 : 4)
                    )
                    .scaleEffect(viewModel.selectedIndex == index ? 1.01 : 0.95)
                    .shadow(color: viewModel.selectedIndex == index ? Color.blue.opacity(0.5) : Color.clear,
                            radius: 7)
                    .overlay(
                        viewModel.selectedIndex == index ?
                            AnyView(RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue.opacity(0.1))) :
                            AnyView(EmptyView())
                    )
                if viewModel.selectedIndex == index {
                    HStack {
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                            .padding(.trailing, 10)
                            .padding(.top, -60)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

// MARK: - Preview
struct GymEquipmentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GymEquipmentView(progressViewModel: ProgressViewModel())
        }
    }
}


