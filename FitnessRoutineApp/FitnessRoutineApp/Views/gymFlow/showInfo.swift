import SwiftUI

struct ShowInfoView: View {
    // Recuperamos los datos almacenados en UserDefaults
    @State private var gender: String = UserDefaults.standard.string(forKey: "gender") ?? "Not Set"
    @State private var height: String = "Not Set" // Inicializamos vacía para actualizarla más tarde
    @State private var weight: String = {
        if let savedWeight = UserDefaults.standard.value(forKey: "selectedWeightKg") as? Double {
            return String(format: "%.1f", savedWeight) // Convertir a String con formato
        }
        return "Not Set"
    }()
    @State private var goal: String = UserDefaults.standard.string(forKey: "selectedGoal") ?? "Not Set"
    @State private var equipmentPreference: String = UserDefaults.standard.string(forKey: "equipmentPreference") ?? "Not Set"
    
    // Nuevas variables para Body Current, Desired Body y Birth Year
    @State private var bodyCurrent: String = UserDefaults.standard.string(forKey: "bodyCurrentImage") ?? "Not Set"
    @State private var desiredBody: String = UserDefaults.standard.string(forKey: "desiredBodyImage") ?? "Not Set"
    @State private var birthYear: String = UserDefaults.standard.string(forKey: "selectedBirthYear") ?? "Not Set"
    
    // Cargar la altura en el onAppear
    func loadHeight() {
        if let storedHeightCm = UserDefaults.standard.value(forKey: "selectedHeightCm") as? Int {
            // Si está almacenada en cm
            height = "\(storedHeightCm) cm"
        } else if let storedHeightFt = UserDefaults.standard.value(forKey: "selectedHeightFt") as? Int,
                  let storedHeightInch = UserDefaults.standard.value(forKey: "selectedHeightInch") as? Int {
            // Si está almacenada en pies y pulgadas
            height = "\(storedHeightFt) ft \(storedHeightInch) in"
        } else {
            height = "Not Set"
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("User Information")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Gender: \(gender)")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                
                Text("Height: \(height)")  // Mostrar la altura correctamente
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                
                Text("Weight: \(weight)") // Mostrar el peso correctamente
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                
                Text("Goal: \(goal)")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                
                Text("Equipment Preference: \(equipmentPreference)")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                
                // Nuevos Labels
                Text("Body Current: \(bodyCurrent)")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                
                Text("Desired Body: \(desiredBody)")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                
                // Mostrar el año de nacimiento
                Text("Birth Year: \(birthYear)")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .background(Color(red: 249/255, green: 249/255, blue: 253/255))
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("Your Information")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: loadHeight) // Cargar la altura cuando la vista aparezca
    }
}

// MARK: - Preview
struct ShowInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ShowInfoView()
    }
}

