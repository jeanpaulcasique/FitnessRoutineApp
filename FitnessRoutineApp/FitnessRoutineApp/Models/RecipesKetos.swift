import Foundation

// MARK: - Recetas Keto (21 recetas: 7 días x 3 comidas)

struct RecipesKeto {
    static let recipes: [Recipe] = [
        // DÍA 1
        Recipe(title: "Keto Breakfast Bowl", mealType: .Breakfast, imageName: "keto_breakfast_bowl",
               ingredients: [
                Ingredient(name: "Scrambled eggs", quantity: "120g"),
                Ingredient(name: "Avocado slices", quantity: "50g"),
                Ingredient(name: "Cheddar cheese", quantity: "30g"),
                Ingredient(name: "Bacon", quantity: "2 slices")
               ],
               instructions: "Whisk eggs and cook in a pan until fluffy. Transfer to a bowl and top with sliced avocado, grated cheddar cheese, and crumbled bacon.",
               calories: 500),

        Recipe(title: "Zucchini Noodle Chicken", mealType: .Lunch, imageName: "keto_zucchini_chicken",
               ingredients: [
                Ingredient(name: "Zucchini noodles", quantity: "100g"),
                Ingredient(name: "Grilled chicken breast", quantity: "150g"),
                Ingredient(name: "Olive oil", quantity: "15ml"),
                Ingredient(name: "Cherry tomatoes", quantity: "50g"),
                Ingredient(name: "Parmesan cheese", quantity: "20g")
               ],
               instructions: "Sauté zucchini noodles in olive oil until al dente. Add grilled chicken and halved cherry tomatoes. Cook for 2 more minutes. Serve with freshly grated parmesan on top.",
               calories: 600),

        Recipe(title: "Salmon with Creamed Spinach", mealType: .Dinner, imageName: "keto_salmon_spinach",
               ingredients: [
                Ingredient(name: "Salmon fillet", quantity: "160g"),
                Ingredient(name: "Spinach", quantity: "100g"),
                Ingredient(name: "Heavy cream", quantity: "30ml"),
                Ingredient(name: "Garlic", quantity: "2 cloves"),
                Ingredient(name: "Butter", quantity: "10g")
               ],
               instructions: "Season salmon with salt and pepper. Bake at 180°C for 15 minutes. In a pan, melt butter, sauté minced garlic, add spinach until wilted. Pour in cream and cook until thickened. Serve salmon over creamed spinach.",
               calories: 650),

        // DÍA 2
        Recipe(title: "Keto Omelette", mealType: .Breakfast, imageName: "keto_omelette",
               ingredients: [
                Ingredient(name: "Eggs", quantity: "3 units"),
                Ingredient(name: "Spinach", quantity: "40g"),
                Ingredient(name: "Feta cheese", quantity: "25g"),
                Ingredient(name: "Red pepper", quantity: "30g"),
                Ingredient(name: "Olive oil", quantity: "5ml")
               ],
               instructions: "Beat eggs with salt and pepper. Heat olive oil in a pan. Pour eggs and cook until edges set. Add spinach, diced red pepper, and crumbled feta. Fold omelette and cook until eggs are set but still moist.",
               calories: 450),

        Recipe(title: "Cauliflower Rice Bowl", mealType: .Lunch, imageName: "keto_cauliflower_bowl",
               ingredients: [
                Ingredient(name: "Cauliflower rice", quantity: "120g"),
                Ingredient(name: "Ground beef", quantity: "150g"),
                Ingredient(name: "Avocado oil", quantity: "10ml"),
                Ingredient(name: "Taco seasoning", quantity: "5g"),
                Ingredient(name: "Avocado", quantity: "50g"),
                Ingredient(name: "Sour cream", quantity: "15g")
               ],
               instructions: "Sauté cauliflower rice in avocado oil until tender. In another pan, cook ground beef with taco seasoning. Serve beef over cauliflower rice, topped with sliced avocado and a dollop of sour cream.",
               calories: 700),

        Recipe(title: "Grilled Pork Chops", mealType: .Dinner, imageName: "keto_pork_chops",
               ingredients: [
                Ingredient(name: "Pork chops", quantity: "180g"),
                Ingredient(name: "Broccoli", quantity: "100g"),
                Ingredient(name: "Butter", quantity: "20g"),
                Ingredient(name: "Garlic powder", quantity: "2g"),
                Ingredient(name: "Rosemary", quantity: "2g")
               ],
               instructions: "Season pork chops with salt, pepper, garlic powder, and rosemary. Grill for about 4-5 minutes per side until internal temperature reaches 145°F. Steam broccoli and toss with melted butter. Serve together.",
               calories: 600),

        // DÍA 3
        Recipe(title: "Avocado Baked Eggs", mealType: .Breakfast, imageName: "keto_avocado_eggs",
               ingredients: [
                Ingredient(name: "Avocado", quantity: "1 unit"),
                Ingredient(name: "Eggs", quantity: "2 units"),
                Ingredient(name: "Bacon", quantity: "2 slices"),
                Ingredient(name: "Chives", quantity: "5g"),
                Ingredient(name: "Cheddar cheese", quantity: "15g")
               ],
               instructions: "Halve avocado and remove pit. Scoop out some flesh to make room for eggs. Crack an egg into each half, sprinkle with cheese. Bake at 200°C for 15 minutes until whites are set. Top with crumbled bacon and chives.",
               calories: 520),

        Recipe(title: "Keto Cobb Salad", mealType: .Lunch, imageName: "keto_cobb_salad",
               ingredients: [
                Ingredient(name: "Romaine lettuce", quantity: "100g"),
                Ingredient(name: "Grilled chicken breast", quantity: "120g"),
                Ingredient(name: "Bacon", quantity: "30g"),
                Ingredient(name: "Hard-boiled eggs", quantity: "2 units"),
                Ingredient(name: "Avocado", quantity: "50g"),
                Ingredient(name: "Blue cheese", quantity: "30g"),
                Ingredient(name: "Olive oil", quantity: "15ml"),
                Ingredient(name: "Lemon juice", quantity: "5ml")
               ],
               instructions: "Arrange chopped lettuce on a plate. Top with sliced grilled chicken, crumbled bacon, quartered hard-boiled eggs, diced avocado, and crumbled blue cheese. Drizzle with olive oil and lemon juice.",
               calories: 680),

        Recipe(title: "Butter Garlic Shrimp", mealType: .Dinner, imageName: "keto_garlic_shrimp",
               ingredients: [
                Ingredient(name: "Shrimp", quantity: "200g"),
                Ingredient(name: "Butter", quantity: "30g"),
                Ingredient(name: "Garlic", quantity: "3 cloves"),
                Ingredient(name: "Lemon juice", quantity: "10ml"),
                Ingredient(name: "Parsley", quantity: "5g"),
                Ingredient(name: "Zucchini", quantity: "100g")
               ],
               instructions: "Melt butter in a large skillet. Add minced garlic and cook until fragrant. Add shrimp and cook until pink, about 2-3 minutes per side. Stir in lemon juice and chopped parsley. Serve with sautéed zucchini slices.",
               calories: 580),

        // DÍA 4
        Recipe(title: "Coconut Chia Pudding", mealType: .Breakfast, imageName: "keto_chia_pudding",
               ingredients: [
                Ingredient(name: "Chia seeds", quantity: "30g"),
                Ingredient(name: "Coconut milk", quantity: "200ml"),
                Ingredient(name: "Vanilla extract", quantity: "2ml"),
                Ingredient(name: "Berries", quantity: "30g"),
                Ingredient(name: "Shredded coconut", quantity: "10g")
               ],
               instructions: "Mix chia seeds, coconut milk, and vanilla extract. Refrigerate overnight. In the morning, top with berries and shredded coconut.",
               calories: 420),

        Recipe(title: "Keto Cheeseburger Wrap", mealType: .Lunch, imageName: "keto_cheeseburger_wrap",
               ingredients: [
                Ingredient(name: "Ground beef", quantity: "150g"),
                Ingredient(name: "Cheddar cheese", quantity: "30g"),
                Ingredient(name: "Lettuce leaves", quantity: "100g"),
                Ingredient(name: "Tomato", quantity: "30g"),
                Ingredient(name: "Onion", quantity: "20g"),
                Ingredient(name: "Pickle", quantity: "20g"),
                Ingredient(name: "Mayonnaise", quantity: "15g"),
                Ingredient(name: "Mustard", quantity: "5g")
               ],
               instructions: "Cook ground beef until browned. Season with salt and pepper. Melt cheese on top. Use large lettuce leaves as wraps, fill with meat and cheese. Add sliced tomato, onion, pickle, and condiments.",
               calories: 620),

        Recipe(title: "Baked Cod with Herb Butter", mealType: .Dinner, imageName: "keto_cod_herbs",
               ingredients: [
                Ingredient(name: "Cod fillets", quantity: "180g"),
                Ingredient(name: "Butter", quantity: "25g"),
                Ingredient(name: "Garlic", quantity: "2 cloves"),
                Ingredient(name: "Mixed herbs", quantity: "5g"),
                Ingredient(name: "Lemon", quantity: "1/2 unit"),
                Ingredient(name: "Asparagus", quantity: "100g")
               ],
               instructions: "Mix softened butter with minced garlic and herbs. Season cod fillets and top with herb butter. Bake at 190°C for 15 minutes until flaky. Roast asparagus on the side and serve with lemon wedges.",
               calories: 550),

        // DÍA 5
        Recipe(title: "Greek Yogurt with Berries", mealType: .Breakfast, imageName: "keto_yogurt_berries",
               ingredients: [
                Ingredient(name: "Greek yogurt (full fat)", quantity: "150g"),
                Ingredient(name: "Mixed berries", quantity: "50g"),
                Ingredient(name: "Almonds", quantity: "15g"),
                Ingredient(name: "Cinnamon", quantity: "1g"),
                Ingredient(name: "Chia seeds", quantity: "5g")
               ],
               instructions: "Place yogurt in a bowl. Top with berries, chopped almonds, a sprinkle of cinnamon, and chia seeds. Mix gently before eating.",
               calories: 380),

        Recipe(title: "Tuna Salad Stuffed Avocado", mealType: .Lunch, imageName: "keto_tuna_avocado",
               ingredients: [
                Ingredient(name: "Canned tuna", quantity: "120g"),
                Ingredient(name: "Avocado", quantity: "1 unit"),
                Ingredient(name: "Mayonnaise", quantity: "20g"),
                Ingredient(name: "Celery", quantity: "20g"),
                Ingredient(name: "Red onion", quantity: "15g"),
                Ingredient(name: "Lemon juice", quantity: "5ml"),
                Ingredient(name: "Dill", quantity: "2g")
               ],
               instructions: "Mix tuna with mayonnaise, diced celery, minced red onion, lemon juice, and dill. Cut avocado in half, remove pit. Fill avocado halves with tuna salad mixture.",
               calories: 550),

        Recipe(title: "Garlic Butter Steak", mealType: .Dinner, imageName: "keto_garlic_steak",
               ingredients: [
                Ingredient(name: "Ribeye steak", quantity: "200g"),
                Ingredient(name: "Butter", quantity: "30g"),
                Ingredient(name: "Garlic", quantity: "3 cloves"),
                Ingredient(name: "Rosemary", quantity: "3g"),
                Ingredient(name: "Thyme", quantity: "3g"),
                Ingredient(name: "Cauliflower mash", quantity: "120g")
               ],
               instructions: "Season steak with salt and pepper. Sear in hot pan to desired doneness. Add butter, crushed garlic, rosemary, and thyme to pan. Baste steak with herb butter. Let rest before slicing. Serve with cauliflower mash.",
               calories: 700),

        // DÍA 6
        Recipe(title: "Ham and Cheese Egg Cups", mealType: .Breakfast, imageName: "keto_egg_cups",
               ingredients: [
                Ingredient(name: "Eggs", quantity: "4 units"),
                Ingredient(name: "Ham slices", quantity: "60g"),
                Ingredient(name: "Cheddar cheese", quantity: "40g"),
                Ingredient(name: "Spinach", quantity: "30g"),
                Ingredient(name: "Heavy cream", quantity: "30ml"),
                Ingredient(name: "Bell pepper", quantity: "20g")
               ],
               instructions: "Line muffin tin cups with ham slices. Mix eggs with cream, salt, and pepper. Add chopped spinach and diced bell pepper. Pour mixture into ham cups, top with cheese. Bake at 180°C for 15 minutes until set.",
               calories: 480),

        Recipe(title: "Chicken Caesar Salad", mealType: .Lunch, imageName: "keto_caesar_salad",
               ingredients: [
                Ingredient(name: "Romaine lettuce", quantity: "100g"),
                Ingredient(name: "Grilled chicken breast", quantity: "150g"),
                Ingredient(name: "Parmesan cheese", quantity: "30g"),
                Ingredient(name: "Bacon", quantity: "20g"),
                Ingredient(name: "Caesar dressing", quantity: "30ml"),
                Ingredient(name: "Avocado", quantity: "50g")
               ],
               instructions: "Tear lettuce into bite-sized pieces. Top with sliced grilled chicken, crumbled bacon, shaved parmesan, and diced avocado. Drizzle with keto-friendly Caesar dressing.",
               calories: 650),

        Recipe(title: "Beef and Broccoli Stir-Fry", mealType: .Dinner, imageName: "keto_beef_broccoli",
               ingredients: [
                Ingredient(name: "Beef strips", quantity: "180g"),
                Ingredient(name: "Broccoli florets", quantity: "120g"),
                Ingredient(name: "Bell pepper", quantity: "50g"),
                Ingredient(name: "Coconut oil", quantity: "15ml"),
                Ingredient(name: "Soy sauce", quantity: "15ml"),
                Ingredient(name: "Ginger", quantity: "5g"),
                Ingredient(name: "Garlic", quantity: "2 cloves")
               ],
               instructions: "Heat coconut oil in a wok. Add minced ginger and garlic, stir for 30 seconds. Add beef strips and cook until browned. Add broccoli and bell pepper, stir-fry until tender-crisp. Season with soy sauce and serve.",
               calories: 580),

        // DÍA 7
        Recipe(title: "Keto Pancakes", mealType: .Breakfast, imageName: "keto_pancakes",
               ingredients: [
                Ingredient(name: "Almond flour", quantity: "60g"),
                Ingredient(name: "Cream cheese", quantity: "60g"),
                Ingredient(name: "Eggs", quantity: "3 units"),
                Ingredient(name: "Vanilla extract", quantity: "2ml"),
                Ingredient(name: "Butter", quantity: "15g"),
                Ingredient(name: "Berries", quantity: "30g")
               ],
               instructions: "Blend almond flour, cream cheese, eggs, and vanilla until smooth. Heat butter in a pan. Pour small portions of batter to make pancakes. Cook until bubbles form, then flip. Serve with a few berries on top.",
               calories: 520),

        Recipe(title: "Keto Italian Sub Roll-Ups", mealType: .Lunch, imageName: "keto_rollups",
               ingredients: [
                Ingredient(name: "Italian deli meats", quantity: "100g"),
                Ingredient(name: "Provolone cheese", quantity: "40g"),
                Ingredient(name: "Lettuce", quantity: "30g"),
                Ingredient(name: "Tomato", quantity: "30g"),
                Ingredient(name: "Red onion", quantity: "20g"),
                Ingredient(name: "Italian dressing", quantity: "15ml"),
                Ingredient(name: "Black olives", quantity: "20g")
               ],
               instructions: "Layer deli meats on a plate. Top with slices of provolone. Add lettuce, sliced tomato, red onion rings, and olives. Drizzle with Italian dressing. Roll up tightly and slice into pinwheels.",
               calories: 560),

        Recipe(title: "Lemon Butter Chicken Thighs", mealType: .Dinner, imageName: "keto_lemon_chicken",
               ingredients: [
                Ingredient(name: "Chicken thighs", quantity: "200g"),
                Ingredient(name: "Butter", quantity: "30g"),
                Ingredient(name: "Lemon", quantity: "1 unit"),
                Ingredient(name: "Garlic", quantity: "3 cloves"),
                Ingredient(name: "Thyme", quantity: "3g"),
                Ingredient(name: "Green beans", quantity: "100g")
               ],
               instructions: "Season chicken thighs with salt and pepper. Sear skin-side down until crispy. Flip and add butter, crushed garlic, thyme, and lemon slices to pan. Baste chicken with the sauce. Finish in oven at 190°C for 15 minutes. Serve with buttered green beans.",
               calories: 650)
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
