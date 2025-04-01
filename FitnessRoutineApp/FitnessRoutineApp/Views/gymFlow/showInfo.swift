import SwiftUI

struct ShowInfoView: View {
    @State private var progress: Double = 0.0
    @State private var visibleItems: Int = 0
    @State private var isPulsing: Bool = true

    @State private var infoItems: [(text: String, value: String)] = []

    func loadData() {
        let gender = UserDefaults.standard.string(forKey: "gender") ?? "Not Set"
        let height: String
        if let storedHeightCm = UserDefaults.standard.value(forKey: "selectedHeightCm") as? Int {
            height = "\(storedHeightCm) cm"
        } else if let storedHeightFt = UserDefaults.standard.value(forKey: "selectedHeightFt") as? Int,
                  let storedHeightInch = UserDefaults.standard.value(forKey: "selectedHeightInch") as? Int {
            height = "\(storedHeightFt) ft \(storedHeightInch) in"
        } else {
            height = "Not Set"
        }

        let weight = UserDefaults.standard.value(forKey: "selectedWeightKg") as? Double ?? 0.0
        let targetWeight = UserDefaults.standard.value(forKey: "selectedTargetWeight") as? Double ?? 0.0
        let goal = UserDefaults.standard.string(forKey: "selectedGoal") ?? "Not Set"
        let equipmentPreference = UserDefaults.standard.string(forKey: "equipmentPreference") ?? "Not Set"
        let bodyCurrent = UserDefaults.standard.string(forKey: "bodyCurrentImage") ?? "Not Set"
        let desiredBody = UserDefaults.standard.string(forKey: "desiredBodyImage") ?? "Not Set"
        let birthYear = UserDefaults.standard.string(forKey: "selectedBirthYear") ?? "Not Set"
        let target = UserDefaults.standard.string(forKey: "selectedTarget") ?? "Not Set"
        let workoutLevel = UserDefaults.standard.string(forKey: "selectedWorkoutLevel") ?? "Not Set"
        let levelActivity = UserDefaults.standard.string(forKey: "selectedLevelActivity") ?? "Not Set"
        let howOften = UserDefaults.standard.string(forKey: "selectedHowOften") ?? "Not Set"

        // Actualiza infoItems después de cargar los datos
        infoItems = [
            ("Gender", gender),
            ("Height", height),
            ("Weight", String(format: "%.1f kg", weight)),
            ("Target Weight", String(format: "%.1f kg", targetWeight)),
            ("Goal", goal),
            ("Equipment Preference", equipmentPreference),
            ("Body Current", bodyCurrent),
            ("Desired Body", desiredBody),
            ("Birth Year", birthYear),
            ("Target", target),
            ("Workout Level", workoutLevel),  // Ahora se carga correctamente
            ("Level Activity", levelActivity),
            ("How Often", howOften)
        ]

        print("DEBUG: Workout Level -> \(workoutLevel)") // Para depuración en consola
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Your coach is working for you")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .scaleEffect(isPulsing ? 1.1 : 1.0)
                .animation(isPulsing ? Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true) : .default, value: isPulsing)

            // Barra de progreso
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 30)

                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .frame(width: geo.size.width * progress, height: 30)
                }
                .overlay(
                    Text("\(Int(progress * 100))%")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading, 10),
                    alignment: .leading
                )
            }
            .frame(height: 30)
            .padding(.horizontal)

            // Lista de información
            VStack(alignment: .leading, spacing: 10) {
                ForEach(0..<infoItems.count, id: \.self) { index in
                    if index < visibleItems {
                        HStack {
                            Text("• \(infoItems[index].text): ")
                                .font(.body)
                                .foregroundColor(.black) +
                            Text(infoItems[index].value)
                                .fontWeight(.bold)

                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                        .transition(.opacity)
                    }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .onAppear {
            loadData()
            startProgress()
        }
        .onChange(of: progress) { newValue in
            if newValue >= 1.0 {
                isPulsing = false
            }
        }
    }

    private func startProgress() {
        for i in 0..<infoItems.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.4) {
                withAnimation {
                    visibleItems += 1
                    progress = Double(visibleItems) / Double(infoItems.count)
                }
            }
        }
    }
}

struct ShowInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ShowInfoView()
    }
}

