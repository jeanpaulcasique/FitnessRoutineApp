import SwiftUI

// Botón animado al presionar
struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

struct DietView: View {
    @StateObject private var vm = DietViewModel()
    @State private var showGrocerySheet = false

    private let shortFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "E"
        return f
    }()
    
    private var totalCaloriesGoal: Int {
        return Int(vm.getDailyCaloriesTarget())
    }

    private var caloriesByMeal: [MealType: Int] {
        var dict: [MealType: Int] = [:]
        for meal in MealType.allCases {
            // Suma todas las calorías de las recetas para ese mealType en el día seleccionado
            dict[meal] = vm.recipes(for: meal).reduce(0) { $0 + $1.calories }
        }
        return dict
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 20) {
                    headerSection
                    waterRecommendationSection
                    caloriesSection
                    daySelector

                    ZStack(alignment: .bottom) {
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 20) {
                                ForEach(MealType.allCases, id: \.self) { meal in
                                    ForEach(vm.recipes(for: meal)) { recipe in
                                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                            StyledRecipeCard(recipe: recipe)
                                                .padding(.horizontal)  // padding inside tappable area
                                        }
                                        .buttonStyle(PressableButtonStyle())
                                        .contentShape(Rectangle()) // tap only card
                                    }
                                }
                            }
                            .padding(.vertical)
                            .padding(.bottom, 100)
                        }

                        groceryButton
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showGrocerySheet) {
            GroceryListSheetView(vm: vm)
        }
    }

    // MARK: - Sections

    private var headerSection: some View {
        HStack {
            Text("\(vm.selectedDiet) Plan")
                .font(.largeTitle).fontWeight(.black).foregroundColor(.yellow)
            Spacer()
        }
        .padding(.horizontal).padding(.top)
    }

    private var waterRecommendationSection: some View {
        HStack {
            Image(systemName: "drop.fill").foregroundColor(.cyan).font(.title2)
            Text("Water recommended: ")
                .foregroundColor(.white).font(.body).fontWeight(.semibold)
            Text("\(vm.calculateRecommendedWaterIntake())/day")
                .foregroundColor(.yellow).font(.body).fontWeight(.semibold)
            Spacer()
        }
        .padding(.horizontal)
    }

    private var caloriesSection: some View {
        let total = caloriesByMeal.values.reduce(0, +)
        return HStack(spacing: 12) {
            Image(systemName: "flame.fill").foregroundColor(.yellow).font(.title3)
            VStack(alignment: .leading, spacing: 2) {
                Text("Daily Calories")
                    .font(.body).fontWeight(.semibold).foregroundColor(.white)
                Text("\(total) / \(totalCaloriesGoal) kcal")
                    .font(.caption).foregroundColor(.yellow)
            }
            Spacer()
        }
        .padding(.horizontal)
    }

    private var daySelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(vm.days, id: \.self) { day in
                    let label = shortFormatter.string(from: day)
                    VStack(spacing: 8) {
                        Text(label)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                        Text(vm.dayNumber(from: day))
                            .font(.headline).fontWeight(.bold)
                            .foregroundColor(vm.selectedDay == day ? .black : .white)
                            .frame(width: 45, height: 45)
                            .background(vm.selectedDay == day ? Color.yellow : Color.white.opacity(0.1))
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(vm.selectedDay == day ? Color.clear : Color.yellow.opacity(0.3), lineWidth: 2)
                            )
                            .shadow(color: vm.selectedDay == day ? Color.yellow.opacity(0.3) : Color.clear,
                                    radius: 8, x: 0, y: 4)
                    }
                    .onTapGesture {
                        withAnimation(.spring()) { vm.select(day: day) }
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    private var groceryButton: some View {
        Button { showGrocerySheet = true } label: {
            HStack {
                Image(systemName: "cart")
                Text("View Grocery List")
            }
            .foregroundColor(.black)
            .padding()
            .background(Color.yellow)
            .cornerRadius(12)
        }
    }
}

// MARK: StyledRecipeCard

struct StyledRecipeCard: View {
    let recipe: Recipe

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(recipe.imageName)
                .resizable().aspectRatio(contentMode: .fill)
                .frame(height: 140).clipped()

            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), .clear]),
                           startPoint: .bottom, endPoint: .center)

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.title)
                    .font(.headline).fontWeight(.bold).foregroundColor(.yellow)
                    .lineLimit(2)

                HStack {
                    Text(recipe.mealType.displayName)
                        .font(.caption).foregroundColor(.white.opacity(0.9))
                    Spacer()
                    Text("\(recipe.calories) kcal")
                        .font(.caption).fontWeight(.semibold)
                        .foregroundColor(.yellow)
                        .padding(.horizontal, 8).padding(.vertical, 2)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .background(Color(white: 0.15))
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.yellow, lineWidth: 2))
        .shadow(color: Color.yellow.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}

// MARK: RecipeDetailView

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ZStack(alignment: .bottomTrailing) {
                    Image(recipe.imageName)
                        .resizable().aspectRatio(contentMode: .fill)
                        .frame(height: 250).clipped().cornerRadius(16)
                    Text("\(recipe.calories) kcal")
                        .font(.headline).fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.horizontal, 12).padding(.vertical, 6)
                        .background(Color.yellow).cornerRadius(20).padding()
                }
                // Título y tipo
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.title)
                        .font(.title).fontWeight(.bold).foregroundColor(.yellow)
                    Text(recipe.mealType.displayName)
                        .font(.subheadline).foregroundColor(.white.opacity(0.7))
                }
                // Ingredientes
                VStack(alignment: .leading, spacing: 12) {
                    Text("Ingredients")
                        .font(.title2).fontWeight(.bold).foregroundColor(.yellow)
                    ForEach(recipe.ingredients) { ing in
                        Text("• \(ing.name): \(ing.quantity)")
                            .foregroundColor(.white)
                            .font(.body)
                    }
                }
                .padding(.top, 4)
                // Instrucciones
                VStack(alignment: .leading, spacing: 12) {
                    Text("Instructions")
                        .font(.title2).fontWeight(.bold).foregroundColor(.yellow)
                    Text(recipe.instructions)
                        .foregroundColor(.white)
                        .font(.body)
                }
            }
            .padding()
        }
        .background(Color.black.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: Preview

struct DietView_Previews: PreviewProvider {
    static var previews: some View {
        DietView()
    }
}
