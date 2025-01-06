import SwiftUI

struct HeightView: View {
    @ObservedObject var viewModel = HeightViewModel()
    @ObservedObject var progressViewModel = ProgressViewModel()
    @State private var navigateToWeightView = false // Propiedad de estado para la navegación

    var body: some View {
        HStack {
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
                Spacer()

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

                Spacer()

                // Botón Next con NavigationLink
                NavigationLink(
                    destination: WeightView(
                        progressViewModel: progressViewModel,
                        userHeight: viewModel.isCmSelected ? Double(viewModel.selectedHeightCm) : Double(viewModel.selectedHeightFt) * 30.48
                    ),
                    isActive: $navigateToWeightView
                ) {
                    Button(action: {
                        navigateToWeightView = true
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
                    .padding(.horizontal, 20)
                    .simultaneousGesture(TapGesture().onEnded {
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    })
                    .padding(.bottom, 40)
                    .padding(.horizontal,1)
                }
            }

            // Cinta métrica
            VStack {
                Spacer()
                VStack(spacing: 15) {
                    ForEach(getHeightRange(), id: \.self) { height in
                        Text(viewModel.isCmSelected ? "\(height) cm" : "\(height / 12) ft \(height % 12) in")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .offset(x: 0, y: calculateOffset(for: height))
                    }
                }
                .frame(width: 60, height: 300)
                .background(Color.white)
                .border(Color.black)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.height < 0 {
                                if viewModel.isCmSelected {
                                    viewModel.updateHeightInCm(Double(viewModel.selectedHeightCm + 1))
                                } else {
                                    viewModel.incrementFeetAndInches()
                                }
                            } else {
                                if viewModel.isCmSelected {
                                    viewModel.updateHeightInCm(Double(viewModel.selectedHeightCm - 1))
                                } else {
                                    viewModel.decrementFeetAndInches()
                                }
                            }
                        }
                )
                Spacer()
            }
            .padding(.trailing, 10)
        }
        .background(Color(red: 249/255, green: 249/255, blue: 253/255))
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("", displayMode: .inline)
    }

    private func getHeightRange() -> [Int] {
        if viewModel.isCmSelected {
            return Array(100...230).reversed()
        } else {
            return Array(40...98)
        }
    }

    private func calculateOffset(for height: Int) -> CGFloat {
        if viewModel.isCmSelected {
            return CGFloat(viewModel.selectedHeightCm - height) * 3
        } else {
            let totalInches = (viewModel.selectedHeightFt * 12) + viewModel.selectedHeightInch
            return CGFloat(totalInches - height) * -10
        }
    }
}


struct HeightView_Previews: PreviewProvider {
    static var previews: some View {
        HeightView()
    }
}
