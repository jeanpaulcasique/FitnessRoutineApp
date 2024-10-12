import SwiftUI

struct HeightView: View {
    @ObservedObject var viewModel = HeightViewModel()
    @ObservedObject var progressViewModel = ProgressViewModel() // Agregado para la barra de progreso

    var body: some View {
        HStack { // Cambiar a HStack para alinear elementos horizontalmente
            VStack {
                // Barra de progreso
                ProgressBarView(progressViewModel: progressViewModel)
                    .padding(.top, 100)
                    .padding(.horizontal, 20)

                // Título
                Text("What's your height?")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.horizontal, 10)
                    .lineLimit(1)
                    .foregroundColor(.black)

                // Descripción
                Text("We'll calculate your BMI and adjust workouts to best suit your physique!")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    .multilineTextAlignment(.center)

                Spacer().frame(height: 130) // Espacio entre la descripción y el selector

                // Selector cm o pies
                HStack {
                    Button(action: {
                        viewModel.toggleUnit(toCm: true)
                    }) {
                        Text("cm")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(viewModel.isCmSelected ? .white : .black)
                            .padding()
                            .background(viewModel.isCmSelected ? Color.black : Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    Button(action: {
                        viewModel.toggleUnit(toCm: false)
                    }) {
                        Text("ft")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(!viewModel.isCmSelected ? .white : .black)
                            .padding()
                            .background(!viewModel.isCmSelected ? Color.black : Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 40)

                Spacer().frame(height: 20) // Espacio entre el selector y la altura seleccionada

                // Mostrar altura seleccionada
                if viewModel.isCmSelected {
                    Text("\(viewModel.selectedHeightCm) cm")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.blue)
                } else {
                    Text("\(viewModel.selectedHeightFt) ft \(viewModel.selectedHeightInch) in")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.blue)
                }

                Spacer() // Espaciador para empujar la cinta métrica hacia abajo

                // Botón Next
                Button(action: {
                    // Aquí puedes agregar la acción para ir a la siguiente pantalla
                }) {
                    Text("Next")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(12)
                        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }

            // Cinta métrica centrada en la mitad de la pantalla
            VStack {
                Spacer() // Espacio superior para centrar la cinta métrica
                VStack(spacing: 15) { // Reducir el espaciado entre los números
                    ForEach(getHeightRange(), id: \.self) { height in
                        Text(viewModel.isCmSelected ? "\(height) cm" : "\(height / 12) ft \(height % 12) in")
                            .font(.system(size: 14)) // Reducir el tamaño de la fuente
                            .foregroundColor(.black)
                            .offset(x: 0, y: calculateOffset(for: height))
                    }
                }
                .frame(width: 60, height: 200) // Ajustar el ancho y la altura de la cinta métrica
                .background(Color.white)
                .border(Color.black)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.height < 0 {
                                // Movimiento hacia arriba
                                if viewModel.isCmSelected {
                                    viewModel.updateHeightInCm(Double(viewModel.selectedHeightCm + 1))
                                } else {
                                    viewModel.incrementFeetAndInches()
                                }
                            } else {
                                // Movimiento hacia abajo
                                if viewModel.isCmSelected {
                                    viewModel.updateHeightInCm(Double(viewModel.selectedHeightCm - 1))
                                } else {
                                    viewModel.decrementFeetAndInches()
                                }
                            }
                        }
                )
                Spacer() // Espacio inferior para centrar la cinta métrica
            }
            .padding(.trailing, 10) // Agregar un poco de espacio a la derecha
        }
        .background(Color(red: 249/255, green: 249/255, blue: 253/255)) // Fondo de la vista
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("", displayMode: .inline)
    }

    // Generar el rango de alturas para mostrar en la cinta métrica
    private func getHeightRange() -> [Int] {
        if viewModel.isCmSelected {
            return Array(100...230).reversed() // Invertir el rango para que los números estén de mayor a menor
        } else {
            // Convertir a pulgadas para el modo en pies
            return Array(40...98) // 3.3 pies (40 pulgadas) a 8.2 pies (98 pulgadas)
        }
    }

    // Calcular el offset para el desplazamiento de los números en la cinta métrica
    private func calculateOffset(for height: Int) -> CGFloat {
        if viewModel.isCmSelected {
            return CGFloat(viewModel.selectedHeightCm - height) * 3 // Ajuste para la dirección inversa
        } else {
            let totalInches = (viewModel.selectedHeightFt * 12) + viewModel.selectedHeightInch
            return CGFloat(totalInches - height) * -10 // Ajustar para mayor visibilidad en pies/pulgadas
        }
    }
}

struct HeightView_Previews: PreviewProvider {
    static var previews: some View {
        HeightView()
    }
}

