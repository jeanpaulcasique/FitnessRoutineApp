import SwiftUI
import UIKit

// MARK: - NewScreenView
struct NewScreenView: View {
    @StateObject private var viewModel = NewScreenViewModel() // ViewModel local
    @ObservedObject var progressViewModel: ProgressViewModel // ProgressViewModel compartido
    @Environment(\.presentationMode) var presentationMode

    @State private var navigateToNextView = false

    var body: some View {
        VStack(spacing: 20) {
            progressBar
            titleView
            optionsList
            Spacer()
            nextButton
            // NavigationLink oculto para navegar a la siguiente pantalla
            NavigationLink(destination: /* Reemplaza por la vista destino */ EmptyView(), isActive: $navigateToNextView) {
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
        .padding(.bottom, 15)
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
        // Esperamos 0.5 segundos para permitir que se vea la animación antes de navegar
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigateToNextView = true
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

