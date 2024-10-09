import SwiftUI


struct DesiredBodyView: View {
    @ObservedObject var viewModel = DesiredBodyViewModel()
    @ObservedObject var progressViewModel: ProgressViewModel
    
    var body: some View {
        VStack {
            // Barra de progreso
            ProgressBarView(progressViewModel: progressViewModel)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            
            // Título
            Text("What's your desired body shape?")
                .font(.system(size: 29, weight: .bold))
                .padding(.top, 10)
                .padding(.horizontal, 10)
            
            // Contenedor de imágenes con desplazamiento fluido
            GeometryReader { geometry in
                TabView(selection: $viewModel.selectedBodyIndex) {
                    ForEach(0..<viewModel.bodyImages.count, id: \.self) { index in
                        ZStack {
                            Image(viewModel.bodyImages[index])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.65) // Tamaño de la imagen principal
                                .opacity(viewModel.selectedBodyIndex == index ? 1.0 : 0.5) // Opacidad para las imágenes laterales
                                .scaleEffect(viewModel.selectedBodyIndex == index ? 1.1 : 0.9) // Escala de las imágenes laterales
                                .offset(x: viewModel.selectedBodyIndex == index ? 0 : -20) // Mueve las imágenes no seleccionadas ligeramente hacia un lado
                                .animation(.easeInOut(duration: 0.4), value: viewModel.selectedBodyIndex)
                                .tag(index)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(width: geometry.size.width, height: 320)
                .clipped()
            }
            .padding(.vertical, 10)
            
            // Slider para seleccionar el tipo de cuerpo
            Slider(value: Binding(
                get: {
                    Double(viewModel.selectedBodyIndex)
                },
                set: { newValue in
                    viewModel.selectBody(index: Int(newValue))
                }
            ), in: 0...Double(viewModel.bodyImages.count - 1), step: 1)
                .padding(.horizontal, 20)
                .accentColor(.blue)
            
            // Etiquetas de los extremos del slider
            HStack {
                Text("Cut")
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                Text("Extra")
                    .font(.system(size: 16, weight: .semibold))
            }
            .padding(.horizontal, 40)
            .padding(.top, 5)
            
            // Tarjeta con la información del objetivo de grasa corporal
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "target")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Your Target Body Fat")
                        .font(.system(size: 18, weight: .bold))
                }
                
                Text("7% ~ 10% (Reasonable Goal!)")
                    .font(.system(size: 16))
                    .foregroundColor(.green)
                
                Text("Step by step! This goal is practical and friendly for beginners.")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            .padding(.all, 20) // Padding interno para la tarjeta, ajustado a 20
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal, 20) // Padding de 20 en la tarjeta con el fondo azul
            .padding(.bottom, 15)
            
            // Botón "Next"
            Button(action: {
                // Acción del botón
            }) {
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
            .padding(.horizontal, 20) // Padding de 20 en el botón Next
            .padding(.bottom, 20)
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(false)
        .background(Color(red: 249/255, green: 249/255, blue: 253/255))
    }
}


// Vista previa
struct DesiredBodyView_Previews: PreviewProvider {
    static var previews: some View {
        DesiredBodyView(progressViewModel: ProgressViewModel()) // Inicializa tu ProgressViewModel
    }
}
