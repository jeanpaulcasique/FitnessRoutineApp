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
    
    var body: some View {
        VStack(spacing: 20) {
            progressBar
            titleView
            optionsList
            Spacer()
            nextButton // El botón se mostrará solo cuando se seleccione una opción
            
            // NavigationLink que nos llevará a GymEquipmentView si navigateToNextView es true
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
        .background(backgroundColor)
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
            .foregroundColor(.black)
            .padding(.top, 20)
            .padding(.horizontal, 20)
    }
    
    var optionsList: some View {
        VStack {
            ForEach(viewModel.options.indices, id: \.self) { index in
                HStack {
                    Image(systemName: viewModel.options[index].icon)
                        .foregroundColor(index == viewModel.selectedIndex ? .blue : .black)
                    Text(viewModel.options[index].title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(index == viewModel.selectedIndex ? .blue : .black)
                    Spacer()
                    if index == viewModel.selectedIndex {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(index == viewModel.selectedIndex ? Color.blue.opacity(0.1) : Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(index == viewModel.selectedIndex ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
                )
                .onTapGesture {
                    viewModel.selectOption(at: index)
                    triggerHapticFeedback()
                }
            }
        }
        .padding(.horizontal, 20)
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
        .padding(.bottom, 0)
        .opacity(viewModel.selectedIndex == nil ? 0 : 1) // Ocultar el botón hasta que se seleccione una opción
        .disabled(viewModel.selectedIndex == nil) // Asegura que esté deshabilitado hasta que se seleccione una opción
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
    
    // MARK: - Acciones
    
    func proceedToNext() {
        // Actualizamos la barra de progreso con animación durante 0.5 segundos
        withAnimation(.easeInOut(duration: 0.5)) {
            progressViewModel.advanceProgress()
        }
        triggerHapticFeedback()
        
        // Esperamos un breve tiempo para que se aprecie la animación
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // Asegúrate de que solo las opciones "At home" (índice 0) o "Any place is ok" (índice 2) naveguen
            if viewModel.selectedIndex == 0 || viewModel.selectedIndex == 2 {
                self.navigateToNextView = true
            } else if viewModel.selectedIndex == 1 {
                // Si se selecciona "At the gym" (índice 1), navegamos a ShowInfoView
                self.navigateToShowInfo = true
            }
        }
    }
    
    func goBack() {
        progressViewModel.decreaseProgress()
        presentationMode.wrappedValue.dismiss()
    }
    
    func triggerHapticFeedback() {
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

