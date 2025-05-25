import Foundation

// MARK: - Recetas Déficit Calórico (21 recetas: 7 días x 3 comidas)

struct RecipesDeficit {
    static let recipes: [Recipe] = [
        // DÍA 1
        Recipe(title: "Overnight Oats with Berries", mealType: .Breakfast, imageName: "deficit_overnight_oats",
               ingredients: [
                Ingredient(name: "Rolled oats", quantity: "40g"),
                Ingredient(name: "Greek yogurt (low fat)", quantity: "100g"),
                Ingredient(name: "Mixed berries", quantity: "80g"),
                Ingredient(name: "Chia seeds", quantity: "10g"),
                Ingredient(name: "Almond milk", quantity: "100ml")
               ],
               instructions: "Mix oats, Greek yogurt, chia seeds, and almond milk in a jar. Refrigerate overnight. In the morning, top with fresh berries and enjoy cold.",
               calories: 320),

        Recipe(title: "Grilled Chicken Salad", mealType: .Lunch, imageName: "deficit_chicken_salad",
               ingredients: [
                Ingredient(name: "Grilled chicken breast", quantity: "120g"),
                Ingredient(name: "Mixed greens", quantity: "100g"),
                Ingredient(name: "Cherry tomatoes", quantity: "80g"),
                Ingredient(name: "Cucumber", quantity: "60g"),
                Ingredient(name: "Bell pepper", quantity: "50g"),
                Ingredient(name: "Olive oil", quantity: "10ml"),
                Ingredient(name: "Lemon juice", quantity: "15ml")
               ],
               instructions: "Grill chicken breast seasoned with herbs. Chop all vegetables and arrange on a plate with mixed greens. Slice chicken and place on top. Drizzle with olive oil and lemon juice.",
               calories: 380),

        Recipe(title: "Baked Cod with Vegetables", mealType: .Dinner, imageName: "deficit_cod_vegetables",
               ingredients: [
                Ingredient(name: "Cod fillet", quantity: "150g"),
                Ingredient(name: "Broccoli", quantity: "100g"),
                Ingredient(name: "Carrots", quantity: "80g"),
                Ingredient(name: "Zucchini", quantity: "80g"),
                Ingredient(name: "Olive oil", quantity: "8ml"),
                Ingredient(name: "Lemon", quantity: "1/2 unit"),
                Ingredient(name: "Herbs (dill/parsley)", quantity: "5g")
               ],
               instructions: "Season cod with herbs, salt, and pepper. Bake at 180°C for 15 minutes. Steam vegetables until tender. Drizzle everything with olive oil and lemon juice before serving.",
               calories: 350),

        // DÍA 2
        Recipe(title: "Vegetable Scrambled Eggs", mealType: .Breakfast, imageName: "deficit_veggie_eggs",
               ingredients: [
                Ingredient(name: "Eggs", quantity: "2 units"),
                Ingredient(name: "Spinach", quantity: "50g"),
                Ingredient(name: "Mushrooms", quantity: "60g"),
                Ingredient(name: "Tomatoes", quantity: "40g"),
                Ingredient(name: "Bell pepper", quantity: "30g"),
                Ingredient(name: "Cooking spray", quantity: "2ml")
               ],
               instructions: "Heat pan with cooking spray. Sauté diced vegetables until tender. Beat eggs and pour into pan with vegetables. Scramble until eggs are set but still creamy.",
               calories: 280),

        Recipe(title: "Turkey and Quinoa Bowl", mealType: .Lunch, imageName: "deficit_turkey_quinoa",
               ingredients: [
                Ingredient(name: "Ground turkey (lean)", quantity: "100g"),
                Ingredient(name: "Cooked quinoa", quantity: "80g"),
                Ingredient(name: "Black beans", quantity: "60g"),
                Ingredient(name: "Corn kernels", quantity: "40g"),
                Ingredient(name: "Avocado", quantity: "30g"),
                Ingredient(name: "Salsa", quantity: "30g"),
                Ingredient(name: "Lime juice", quantity: "10ml")
               ],
               instructions: "Cook ground turkey with seasonings until browned. Arrange quinoa in a bowl, top with turkey, black beans, corn, and diced avocado. Add salsa and squeeze lime juice over everything.",
               calories: 420),

        Recipe(title: "Zucchini Noodles with Shrimp", mealType: .Dinner, imageName: "deficit_zucchini_shrimp",
               ingredients: [
                Ingredient(name: "Shrimp", quantity: "140g"),
                Ingredient(name: "Zucchini noodles", quantity: "150g"),
                Ingredient(name: "Cherry tomatoes", quantity: "80g"),
                Ingredient(name: "Garlic", quantity: "2 cloves"),
                Ingredient(name: "Olive oil", quantity: "8ml"),
                Ingredient(name: "Basil", quantity: "5g"),
                Ingredient(name: "Lemon juice", quantity: "10ml")
               ],
               instructions: "Sauté garlic in olive oil. Add shrimp and cook until pink. Add cherry tomatoes and cook until softened. Toss with zucchini noodles, fresh basil, and lemon juice. Cook for 2 minutes until heated through.",
               calories: 320),

        // DÍA 3
        Recipe(title: "Smoothie Bowl", mealType: .Breakfast, imageName: "deficit_smoothie_bowl",
               ingredients: [
                Ingredient(name: "Frozen banana", quantity: "100g"),
                Ingredient(name: "Frozen berries", quantity: "80g"),
                Ingredient(name: "Protein powder", quantity: "20g"),
                Ingredient(name: "Almond milk", quantity: "150ml"),
                Ingredient(name: "Granola (low sugar)", quantity: "20g"),
                Ingredient(name: "Fresh strawberries", quantity: "50g")
               ],
               instructions: "Blend frozen fruits with protein powder and almond milk until thick. Pour into a bowl and top with granola and sliced fresh strawberries.",
               calories: 340),

        Recipe(title: "Lentil and Vegetable Soup", mealType: .Lunch, imageName: "deficit_lentil_soup",
               ingredients: [
                Ingredient(name: "Red lentils", quantity: "80g"),
                Ingredient(name: "Carrots", quantity: "60g"),
                Ingredient(name: "Celery", quantity: "50g"),
                Ingredient(name: "Onion", quantity: "40g"),
                Ingredient(name: "Vegetable broth", quantity: "400ml"),
                Ingredient(name: "Canned tomatoes", quantity: "100g"),
                Ingredient(name: "Spinach", quantity: "40g")
               ],
               instructions: "Sauté diced onion, carrots, and celery. Add lentils, broth, and canned tomatoes. Simmer for 20 minutes until lentils are tender. Stir in spinach until wilted. Season with herbs and spices.",
               calories: 360),

        Recipe(title: "Grilled Salmon with Asparagus", mealType: .Dinner, imageName: "deficit_salmon_asparagus",
               ingredients: [
                Ingredient(name: "Salmon fillet", quantity: "130g"),
                Ingredient(name: "Asparagus", quantity: "150g"),
                Ingredient(name: "Sweet potato", quantity: "100g"),
                Ingredient(name: "Olive oil", quantity: "8ml"),
                Ingredient(name: "Lemon", quantity: "1/2 unit"),
                Ingredient(name: "Garlic powder", quantity: "2g")
               ],
               instructions: "Season salmon with garlic powder, salt, and pepper. Grill for 4-5 minutes per side. Roast asparagus and cubed sweet potato at 200°C for 20 minutes with a drizzle of olive oil. Serve with lemon wedges.",
               calories: 400),

        // DÍA 4
        Recipe(title: "Greek Yogurt Parfait", mealType: .Breakfast, imageName: "deficit_yogurt_parfait",
               ingredients: [
                Ingredient(name: "Greek yogurt (fat-free)", quantity: "150g"),
                Ingredient(name: "Mixed berries", quantity: "100g"),
                Ingredient(name: "Honey", quantity: "10ml"),
                Ingredient(name: "Almonds (sliced)", quantity: "15g"),
                Ingredient(name: "Cinnamon", quantity: "1g")
               ],
               instructions: "Layer Greek yogurt with berries in a glass. Drizzle with honey, sprinkle with sliced almonds and cinnamon. Repeat layers and enjoy immediately.",
               calories: 300),

        Recipe(title: "Chickpea and Veggie Wrap", mealType: .Lunch, imageName: "deficit_chickpea_wrap",
               ingredients: [
                Ingredient(name: "Whole wheat tortilla", quantity: "1 unit"),
                Ingredient(name: "Chickpeas (cooked)", quantity: "100g"),
                Ingredient(name: "Hummus", quantity: "30g"),
                Ingredient(name: "Lettuce", quantity: "30g"),
                Ingredient(name: "Tomatoes", quantity: "50g"),
                Ingredient(name: "Cucumber", quantity: "40g"),
                Ingredient(name: "Red onion", quantity: "20g")
               ],
               instructions: "Mash chickpeas slightly and season with spices. Spread hummus on tortilla, add lettuce, diced tomatoes, cucumber, and red onion. Add seasoned chickpeas, roll tightly, and slice in half.",
               calories: 390),

        Recipe(title: "Chicken and Vegetable Stir-Fry", mealType: .Dinner, imageName: "deficit_chicken_stirfry",
               ingredients: [
                Ingredient(name: "Chicken breast", quantity: "120g"),
                Ingredient(name: "Broccoli florets", quantity: "100g"),
                Ingredient(name: "Bell peppers", quantity: "80g"),
                Ingredient(name: "Snow peas", quantity: "60g"),
                Ingredient(name: "Brown rice (cooked)", quantity: "80g"),
                Ingredient(name: "Soy sauce (low sodium)", quantity: "15ml"),
                Ingredient(name: "Sesame oil", quantity: "5ml")
               ],
               instructions: "Cut chicken into strips. Heat sesame oil in wok, cook chicken until done. Add vegetables and stir-fry until tender-crisp. Season with soy sauce. Serve over brown rice.",
               calories: 380),

        // DÍA 5
        Recipe(title: "Avocado Toast", mealType: .Breakfast, imageName: "deficit_avocado_toast",
               ingredients: [
                Ingredient(name: "Whole grain bread", quantity: "2 slices"),
                Ingredient(name: "Avocado", quantity: "80g"),
                Ingredient(name: "Cherry tomatoes", quantity: "60g"),
                Ingredient(name: "Lime juice", quantity: "10ml"),
                Ingredient(name: "Everything bagel seasoning", quantity: "2g"),
                Ingredient(name: "Red pepper flakes", quantity: "1g")
               ],
               instructions: "Toast bread until golden. Mash avocado with lime juice, salt, and pepper. Spread on toast, top with halved cherry tomatoes, and sprinkle with seasoning and red pepper flakes.",
               calories: 350),

        Recipe(title: "Mediterranean Bowl", mealType: .Lunch, imageName: "deficit_mediterranean_bowl",
               ingredients: [
                Ingredient(name: "Quinoa (cooked)", quantity: "100g"),
                Ingredient(name: "Cucumber", quantity: "80g"),
                Ingredient(name: "Cherry tomatoes", quantity: "80g"),
                Ingredient(name: "Olives", quantity: "20g"),
                Ingredient(name: "Feta cheese", quantity: "30g"),
                Ingredient(name: "Red onion", quantity: "20g"),
                Ingredient(name: "Olive oil", quantity: "10ml"),
                Ingredient(name: "Lemon juice", quantity: "15ml")
               ],
               instructions: "Arrange quinoa in a bowl. Top with diced cucumber, halved tomatoes, sliced red onion, olives, and crumbled feta. Drizzle with olive oil and lemon juice. Mix before eating.",
               calories: 410),

        Recipe(title: "Turkey Meatballs with Zucchini", mealType: .Dinner, imageName: "deficit_turkey_meatballs",
               ingredients: [
                Ingredient(name: "Ground turkey (lean)", quantity: "140g"),
                Ingredient(name: "Zucchini", quantity: "200g"),
                Ingredient(name: "Egg white", quantity: "1 unit"),
                Ingredient(name: "Breadcrumbs", quantity: "20g"),
                Ingredient(name: "Marinara sauce", quantity: "100g"),
                Ingredient(name: "Italian herbs", quantity: "3g")
               ],
               instructions: "Mix ground turkey with egg white, breadcrumbs, and herbs. Form into meatballs and bake at 180°C for 20 minutes. Spiralize zucchini and sauté briefly. Serve meatballs over zucchini noodles with marinara sauce.",
               calories: 360),

        // DÍA 6
        Recipe(title: "Cottage Cheese Bowl", mealType: .Breakfast, imageName: "deficit_cottage_cheese",
               ingredients: [
                Ingredient(name: "Cottage cheese (low fat)", quantity: "150g"),
                Ingredient(name: "Pineapple chunks", quantity: "80g"),
                Ingredient(name: "Walnuts", quantity: "15g"),
                Ingredient(name: "Cinnamon", quantity: "1g"),
                Ingredient(name: "Vanilla extract", quantity: "2ml")
               ],
               instructions: "Mix cottage cheese with vanilla extract and cinnamon. Top with pineapple chunks and chopped walnuts. Serve chilled.",
               calories: 290),

        Recipe(title: "Tuna and White Bean Salad", mealType: .Lunch, imageName: "deficit_tuna_bean_salad",
               ingredients: [
                Ingredient(name: "Canned tuna (in water)", quantity: "120g"),
                Ingredient(name: "White beans", quantity: "100g"),
                Ingredient(name: "Arugula", quantity: "60g"),
                Ingredient(name: "Cherry tomatoes", quantity: "80g"),
                Ingredient(name: "Red onion", quantity: "20g"),
                Ingredient(name: "Olive oil", quantity: "10ml"),
                Ingredient(name: "Balsamic vinegar", quantity: "15ml")
               ],
               instructions: "Drain tuna and flake into pieces. Rinse white beans. Combine with arugula, halved tomatoes, and sliced red onion. Dress with olive oil and balsamic vinegar.",
               calories: 370),

        Recipe(title: "Stuffed Bell Peppers", mealType: .Dinner, imageName: "deficit_stuffed_peppers",
               ingredients: [
                Ingredient(name: "Bell peppers", quantity: "2 units"),
                Ingredient(name: "Ground turkey (lean)", quantity: "100g"),
                Ingredient(name: "Brown rice (cooked)", quantity: "60g"),
                Ingredient(name: "Diced tomatoes", quantity: "80g"),
                Ingredient(name: "Onion", quantity: "30g"),
                Ingredient(name: "Low-fat cheese", quantity: "20g"),
                Ingredient(name: "Italian seasoning", quantity: "3g")
               ],
               instructions: "Cut tops off peppers and remove seeds. Cook turkey with diced onion until browned. Mix with rice, tomatoes, and seasoning. Stuff peppers with mixture, top with cheese. Bake at 180°C for 25 minutes.",
               calories: 380),

        // DÍA 7
        Recipe(title: "Protein Pancakes", mealType: .Breakfast, imageName: "deficit_protein_pancakes",
               ingredients: [
                Ingredient(name: "Egg whites", quantity: "4 units"),
                Ingredient(name: "Banana", quantity: "1 small unit"),
                Ingredient(name: "Protein powder", quantity: "25g"),
                Ingredient(name: "Oat flour", quantity: "20g"),
                Ingredient(name: "Blueberries", quantity: "60g"),
                Ingredient(name: "Cooking spray", quantity: "2ml")
               ],
               instructions: "Blend egg whites, banana, protein powder, and oat flour until smooth. Heat pan with cooking spray. Pour batter to make small pancakes. Cook until bubbles form, flip, and cook until golden. Serve with blueberries.",
               calories: 330),

        Recipe(title: "Asian Lettuce Wraps", mealType: .Lunch, imageName: "deficit_lettuce_wraps",
               ingredients: [
                Ingredient(name: "Ground chicken (lean)", quantity: "120g"),
                Ingredient(name: "Butter lettuce", quantity: "8 leaves"),
                Ingredient(name: "Water chestnuts", quantity: "40g"),
                Ingredient(name: "Carrots", quantity: "30g"),
                Ingredient(name: "Green onions", quantity: "20g"),
                Ingredient(name: "Soy sauce (low sodium)", quantity: "15ml"),
                Ingredient(name: "Rice vinegar", quantity: "10ml"),
                Ingredient(name: "Sesame oil", quantity: "3ml")
               ],
               instructions: "Cook ground chicken until browned. Add diced water chestnuts, carrots, and green onions. Season with soy sauce, rice vinegar, and sesame oil. Serve mixture in lettuce cups.",
               calories: 320),

        Recipe(title: "Baked Tilapia with Roasted Vegetables", mealType: .Dinner, imageName: "deficit_tilapia_vegetables",
               ingredients: [
                Ingredient(name: "Tilapia fillets", quantity: "150g"),
                Ingredient(name: "Brussels sprouts", quantity: "100g"),
                Ingredient(name: "Cauliflower", quantity: "100g"),
                Ingredient(name: "Red bell pepper", quantity: "80g"),
                Ingredient(name: "Olive oil", quantity: "10ml"),
                Ingredient(name: "Lemon", quantity: "1/2 unit"),
                Ingredient(name: "Paprika", quantity: "2g")
               ],
               instructions: "Season tilapia with paprika, salt, and pepper. Chop vegetables and toss with half the olive oil. Roast vegetables at 200°C for 20 minutes. Bake tilapia for 12 minutes. Drizzle with remaining oil and lemon juice.",
               calories: 340)
    ]
    
    // Función para obtener todas las recetas
    static func getAllRecipes() -> [Recipe] {
        return recipes
    }
    
    // Función para obtener recetas por tipo de comida
    static func getRecipes(for mealType: MealType) -> [Recipe] {
        return recipes.filter { $0.mealType == mealType }
    }
    
    // Función para obtener recetas organizadas por día (7 días, 3 comidas por día)
    static func getRecipesOrganizedByDay() -> [[Recipe]] {
        var result: [[Recipe]] = []
        
        let breakfasts = getRecipes(for: .Breakfast)
        let lunches = getRecipes(for: .Lunch)
        let dinners = getRecipes(for: .Dinner)
        
        // Asumimos que hay 7 desayunos, 7 almuerzos y 7 cenas
        let daysCount = 7
        
        for day in 0..<daysCount {
            let dayRecipes = [
                breakfasts[day],
                lunches[day],
                dinners[day]
            ]
            result.append(dayRecipes)
        }
        
        return result
    }
}
