import SwiftUI
import UIKit

// MARK: - NewScreenView
struct NewScreenView: View {
    @StateObject private var viewModel = NewScreenViewModel() // ViewModel local
    @ObservedObject var progressViewModel: ProgressViewModel  // ProgressViewModel compartido
    @Environment(\.presentationMode) var presentationMode

    // Controla la navegación a la siguiente vista
    @State private var navigateToNextView = false
    @State private var navigateToShowInfo = false  // Nueva variable para controlar la navegación a ShowInfo
    @State private var isNextButtonDisabled = false  // Estado para habilitar/deshabilitar el botón
    @State private var isNextButtonLoading = false   // Estado de loading del botón

    var body: some View {
        VStack(spacing: 20) {
            progressBar
            titleView
            optionsList
            Spacer()

            NextButton(
                title: "Next",
                action: proceedToNext,
                isLoading: $isNextButtonLoading,
                isDisabled: $isNextButtonDisabled
            )
            .padding(.bottom, 0)
            .opacity(viewModel.selectedIndex == nil ? 0 : 1)

            NavigationLink(
                destination: GymEquipmentView(progressViewModel: progressViewModel),
                isActive: $navigateToNextView
            ) {
                EmptyView()
            }
            
            // NavigationLink para ShowInfoView si se selecciona "At the gym"
            NavigationLink(
                destination: ShowInfoView(),
                isActive: $navigateToShowInfo
            ) {
                EmptyView()
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar { backButton }
    }
}

// MARK: - Subviews & Helpers
private extension NewScreenView {
    var progressBar: some View {
        ProgressBarView(progressViewModel: progressViewModel)
            .padding(.top, 20)
            .padding(.horizontal, 20)
    }
    
    var titleView: some View {
        Text("Which place do you prefer for your workout?")
            .font(.system(size: 29, weight: .bold))
            .multilineTextAlignment(.center)
            .foregroundColor(.yellow)
            .padding(.top, 20)
            .padding(.horizontal, 20)
    }
    
    var optionsList: some View {
        VStack {
            ForEach(viewModel.options.indices, id: \.self) { index in
                HStack {
                    Image(systemName: viewModel.options[index].icon)
                        .foregroundColor(index == viewModel.selectedIndex ? .yellow : .white)
                    Text(viewModel.options[index].title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(index == viewModel.selectedIndex ? .yellow : .white)
                    Spacer()
                    if index == viewModel.selectedIndex {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.yellow)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(index == viewModel.selectedIndex ? Color.yellow.opacity(0.1) : Color.black)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(index == viewModel.selectedIndex ? Color.yellow : Color.white.opacity(0.2), lineWidth: 1)
                )
                .onTapGesture {
                    viewModel.selectOption(at: index)
                    triggerHapticFeedback()
                }
            }
        }
        .padding(.horizontal, 20)
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
    
    var backgroundColor: Color {
        Color(red: 249/255, green: 249/255, blue: 253/255)
    }
    
    // MARK: - Acciones
    
    private func proceedToNext() {
        // Deshabilitar el botón por 2 segundos
        isNextButtonDisabled = true

        // Actualizamos la barra de progreso
        withAnimation(.easeInOut(duration: 0.5)) {
            progressViewModel.advanceProgress()
        }
        triggerHapticFeedback()
        
        // Esperamos un breve tiempo para que se aprecie la animación
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if viewModel.selectedIndex == 0 || viewModel.selectedIndex == 2 {
                navigateToNextView = true
            } else if viewModel.selectedIndex == 1 {
                navigateToShowInfo = true
            }
        }

        // Habilitar el botón después de 2 segundos
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isNextButtonDisabled = false
            isNextButtonLoading = false
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

// MARK: - Preview
struct NewScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewScreenView(progressViewModel: ProgressViewModel())
        }
    }
}
