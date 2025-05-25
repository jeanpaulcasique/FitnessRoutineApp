import SwiftUI

struct DietView: View {
    @StateObject private var vm = DietViewModel()
    @State private var showGrocerySheet = false

    // Formatter para días cortos en inglés
    private let shortFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "E"
        return f
    }()

    private let totalCaloriesGoal = 2000

    private var caloriesByMeal: [MealType: Int] {
        var dict: [MealType: Int] = [:]
        for meal in MealType.allCases {
            dict[meal] = vm.recipes(for: meal).first?.calories ?? 0
        }
        return dict
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 16) {
                    // Header
                    Text("Your \(vm.selectedDiet) Plan")
                        .font(.title2).bold()
                        .foregroundColor(.yellow)
                        .padding(.top)

                    // Recomendación de agua
                    Text("💧 Recommended water: \(vm.calculateRecommendedWaterIntake()) per day")
                        .foregroundColor(.cyan)
                        .font(.subheadline)

                    // Calorías totales y desglose
                    VStack(alignment: .leading) {
                        Text("Daily Calorie Goal: \(totalCaloriesGoal) kcal")
                            .font(.headline)
                            .foregroundColor(.white)
                        ForEach(MealType.allCases, id: \.self) { meal in
                            HStack {
                                Text(meal.rawValue.capitalized + ":")
                                    .foregroundColor(.white)
                                Spacer()
                                Text("\(caloriesByMeal[meal] ?? 0) kcal")
                                    .foregroundColor(.yellow)
                                    .bold()
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Selector horizontal de días alineado lunes a domingo
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(vm.days, id: \.self) { day in
                                let label = shortFormatter.string(from: day)
                                VStack {
                                    Text(label)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(vm.dayNumber(from: day))
                                        .font(.headline)
                                        .foregroundColor(vm.selectedDay == day ? .black : .white)
                                        .frame(width: 45, height: 45)
                                        .background(vm.selectedDay == day ? Color.yellow : Color.gray.opacity(0.3))
                                        .clipShape(Circle())
                                }
                                .onTapGesture { vm.select(day: day) }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.trailing, 12)
                    }

                    // Scroll vertical con cards de recetas
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach(MealType.allCases, id: \.self) { meal in
                                if let recipe = vm.recipes(for: meal).first {
                                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                        RecipeCard(recipe: recipe)
                                            .padding(.horizontal)
                                    }
                                }
                            }
                        }
                    }

                    // Botón para ver hoja de compras
                    Button(action: { showGrocerySheet = true }) {
                        HStack {
                            Image(systemName: "cart")
                            Text("View Grocery List")
                        }
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(10)
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
}

// MARK: - Subviews

struct RecipeCard: View {
    let recipe: Recipe
    var body: some View {
        HStack {
            Image(recipe.imageName)
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
    }
}

struct RecipeDetailView: View {
    let recipe: Recipe
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(recipe.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                Text(recipe.title)
                    .font(.title)
                    .foregroundColor(.yellow)
                Text("Ingredients:")
                    .font(.headline)
                    .foregroundColor(.white)
                ForEach(recipe.ingredients) { ing in
                    Text("• \(ing.name): \(ing.quantity)").foregroundColor(.white)
                }
                Text("Instructions:")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(recipe.instructions).foregroundColor(.white)
            }
            .padding()
        }
        .background(Color.black.ignoresSafeArea())
    }
}

struct GroceryListSheetView: View {
    @ObservedObject var vm: DietViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showShareSheet = false
    @State private var showUncheckedOnly = false

    var filteredIngredients: [Ingredient] {
        if showUncheckedOnly {
            return vm.groceryList.filter { !$0.isChecked }
        } else {
            return vm.groceryList
        }
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Toggle("Show unchecked only", isOn: $showUncheckedOnly)
                    .padding(.horizontal)

                List {
                    ForEach(filteredIngredients) { item in
                        HStack {
                            Button(action: {
                                vm.toggleCheck(for: item)
                            }) {
                                Image(systemName: item.isChecked ? "checkmark.square.fill" : "square")
                                    .foregroundColor(item.isChecked ? .yellow : .white)
                            }
                            Text(item.name)
                                .foregroundColor(.white)
                            Spacer()
                            Text(item.quantity)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(PlainListStyle())
                .animation(.default, value: filteredIngredients)

                Spacer()

                Button(action: { showShareSheet = true }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share List")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .cornerRadius(12)
                }
                .padding(.horizontal)

            }
            .navigationTitle("Grocery List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Reset") {
                        for idx in vm.groceryList.indices {
                            vm.groceryList[idx].isChecked = false
                        }
                        vm.saveCheckedIngredientNames()
                    }
                    .foregroundColor(.yellow)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .foregroundColor(.yellow)
                }
            }
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(activityItems: [vm.groceryListText])
            }
            .background(Color.black.ignoresSafeArea())
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

// MARK: - Preview

struct DietView_Previews: PreviewProvider {
    static var previews: some View {
        DietView()
    }
}

