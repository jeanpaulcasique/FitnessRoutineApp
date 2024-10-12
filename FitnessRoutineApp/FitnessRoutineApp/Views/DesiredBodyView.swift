import SwiftUI

struct DesiredBodyView: View {
    @ObservedObject var viewModel = DesiredBodyViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    @State private var selectedBodyIndex: Int = 0 // Usar @State para manejar el índice seleccionado
    @State private var isNavigatingToBirthYearView = false // Estado para controlar la navegación

    var body: some View {
        VStack {
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            
            Text("What's your desired body shape?")
                .font(.system(size: 31, weight: .bold))
                .padding(.top, 10)
                .foregroundColor(.black)
                .padding(.horizontal, 10)
            
            GeometryReader { geometry in
                TabView(selection: $selectedBodyIndex) {
                    ForEach(0..<viewModel.bodyImages.count, id: \.self) { index in
                        ZStack {
                            Image(viewModel.bodyImages[index])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.65)
                                .opacity(selectedBodyIndex == index ? 1.0 : 0.5)
                                .scaleEffect(selectedBodyIndex == index ? 1.1 : 0.9)
                                .offset(x: selectedBodyIndex == index ? 0 : -20)
                                .animation(.easeInOut(duration: 0.4), value: selectedBodyIndex)
                                .tag(index)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(width: geometry.size.width, height: 320)
                .clipped()
                .onChange(of: selectedBodyIndex) { newIndex in
                    // Vibrar al cambiar de imagen
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                }
            }
            .padding(.vertical, 10)
            
            Slider(value: Binding(
                get: { Double(selectedBodyIndex) },
                set: { newValue in
                    selectedBodyIndex = Int(newValue)
                    viewModel.selectBody(index: Int(newValue))
                    // Vibrar al cambiar con el slider
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                }
            ), in: 0...Double(viewModel.bodyImages.count - 1), step: 1)
            .padding(.horizontal, 20)
            .accentColor(.blue)
            
            HStack {
                Text("Cut")
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                Text("Extra")
                    .font(.system(size: 16, weight: .semibold))
            }
            .padding(.horizontal, 40)
            .padding(.top, 5)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "target")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                    Text("Your Target Body Fat")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                }
                Text(viewModel.bodyFatRanges[selectedBodyIndex])
                    .font(.system(size: 16))
                    .foregroundColor(viewModel.bodyFatRanges[selectedBodyIndex].contains("Consult a doctor") ? .red : .green)
                
                Text(viewModel.bodyFatDescriptions[selectedBodyIndex])
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            .padding(.all, 20)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal, 20)
            .padding(.bottom, 15)
            
            // Botón "Next"
            NavigationLink(destination: BirthYearView(viewModel: BirthYearViewModel(), progressViewModel: progressViewModel), isActive: $isNavigatingToBirthYearView) {
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
            .simultaneousGesture(TapGesture().onEnded {
                // Vibrar al presionar "Next"
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                
                progressViewModel.advanceProgress() // Actualiza la barra de progreso antes de navegar
                isNavigatingToBirthYearView = true // Cambiar el estado para navegar
            })
        }
        .navigationBarTitle("", displayMode: .inline)
        .background(Color(red: 249/255, green: 249/255, blue: 253/255))
    }
}

// Vista previa
struct DesiredBodyView_Previews: PreviewProvider {
    static var previews: some View {
        DesiredBodyView(progressViewModel: ProgressViewModel())
    }
}

