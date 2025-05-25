
import Foundation

// MARK: - Recetas Low Carb (21 recetas: 7 días x 3 comidas)

struct RecipesLowCarb {
    static let recipes: [Recipe] = [
        // DÍA 1
        Recipe(title: "Vegetable Omelette", mealType: .Breakfast, imageName: "lowcarb_vegetable_omelette",
               ingredients: [
                Ingredient(name: "Eggs", quantity: "3 units"),
                Ingredient(name: "Bell pepper", quantity: "40g"),
                Ingredient(name: "Spinach", quantity: "30g"),
                Ingredient(name: "Mushrooms", quantity: "40g"),
                Ingredient(name: "Feta cheese", quantity: "25g"),
                Ingredient(name: "Olive oil", quantity: "5ml")
               ],
               instructions: "Beat eggs with salt and pepper. Heat olive oil in a pan. Sauté chopped bell pepper, spinach, and mushrooms until softened. Pour in eggs and cook until edges set. Sprinkle with crumbled feta. Fold omelette and cook until eggs are set but still moist.",
               calories: 380),

        Recipe(title: "Grilled Chicken Salad", mealType: .Lunch, imageName: "lowcarb_chicken_salad",
               ingredients: [
                Ingredient(name: "Chicken breast", quantity: "150g"),
                Ingredient(name: "Mixed greens", quantity: "100g"),
                Ingredient(name: "Cherry tomatoes", quantity: "50g"),
                Ingredient(name: "Cucumber", quantity: "50g"),
                Ingredient(name: "Avocado", quantity: "50g"),
                Ingredient(name: "Olive oil", quantity: "10ml"),
                Ingredient(name: "Lemon juice", quantity: "5ml"),
                Ingredient(name: "Dijon mustard", quantity: "5g")
               ],
               instructions: "Season chicken breast with salt and pepper. Grill until cooked through. Slice and let cool. Combine mixed greens, halved cherry tomatoes, sliced cucumber, and diced avocado. In a small bowl, whisk olive oil, lemon juice, and Dijon mustard. Arrange chicken on salad and drizzle with dressing.",
               calories: 450),

        Recipe(title: "Baked Lemon Herb Tilapia", mealType: .Dinner, imageName: "lowcarb_lemon_tilapia",
               ingredients: [
                Ingredient(name: "Tilapia fillets", quantity: "180g"),
                Ingredient(name: "Lemon", quantity: "1 unit"),
                Ingredient(name: "Fresh herbs (thyme, parsley)", quantity: "10g"),
                Ingredient(name: "Garlic", quantity: "2 cloves"),
                Ingredient(name: "Olive oil", quantity: "10ml"),
                Ingredient(name: "Asparagus", quantity: "100g"),
                Ingredient(name: "Cherry tomatoes", quantity: "50g")
               ],
               instructions: "Preheat oven to 200°C. Place tilapia on parchment paper. Drizzle with olive oil. Top with minced garlic, lemon slices, and chopped herbs. Season with salt and pepper. Add asparagus and tomatoes around fish. Fold parchment into a packet. Bake for 15 minutes until fish flakes easily.",
               calories: 320),

        // DÍA 2
        Recipe(title: "Greek Yogurt Parfait", mealType: .Breakfast, imageName: "lowcarb_yogurt_parfait",
               ingredients: [
                Ingredient(name: "Greek yogurt (full fat)", quantity: "200g"),
                Ingredient(name: "Berries", quantity: "60g"),
                Ingredient(name: "Almonds", quantity: "20g"),
                Ingredient(name: "Cinnamon", quantity: "1g"),
                Ingredient(name: "Vanilla extract", quantity: "2ml")
               ],
               instructions: "In a glass, layer Greek yogurt, berries, and chopped almonds. Repeat layers. Sprinkle with cinnamon and add a few drops of vanilla extract.",
               calories: 300),

        Recipe(title: "Turkey Lettuce Wraps", mealType: .Lunch, imageName: "lowcarb_turkey_wraps",
               ingredients: [
                Ingredient(name: "Ground turkey", quantity: "150g"),
                Ingredient(name: "Red bell pepper", quantity: "50g"),
                Ingredient(name: "Water chestnuts", quantity: "30g"),
                Ingredient(name: "Carrots", quantity: "40g"),
                Ingredient(name: "Green onions", quantity: "20g"),
                Ingredient(name: "Garlic", quantity: "2 cloves"),
                Ingredient(name: "Ginger", quantity: "5g"),
                Ingredient(name: "Soy sauce", quantity: "10ml"),
                Ingredient(name: "Lettuce leaves", quantity: "100g")
               ],
               instructions: "Brown ground turkey in a pan. Add minced garlic and ginger, cook until fragrant. Add diced bell pepper, water chestnuts, and shredded carrots. Cook until vegetables are tender. Stir in chopped green onions and soy sauce. Serve in lettuce cups.",
               calories: 380),

        Recipe(title: "Mediterranean Baked Salmon", mealType: .Dinner, imageName: "lowcarb_mediterranean_salmon",
               ingredients: [
                Ingredient(name: "Salmon fillet", quantity: "180g"),
                Ingredient(name: "Cherry tomatoes", quantity: "100g"),
                Ingredient(name: "Kalamata olives", quantity: "30g"),
                Ingredient(name: "Red onion", quantity: "40g"),
                Ingredient(name: "Feta cheese", quantity: "30g"),
                Ingredient(name: "Olive oil", quantity: "10ml"),
                Ingredient(name: "Lemon juice", quantity: "10ml"),
                Ingredient(name: "Oregano", quantity: "2g"),
                Ingredient(name: "Zucchini", quantity: "100g")
               ],
               instructions: "Preheat oven to 190°C. Place salmon on a baking sheet. Combine halved cherry tomatoes, sliced olives, diced red onion, and cubed feta. Place around salmon. Drizzle everything with olive oil and lemon juice. Sprinkle with oregano, salt, and pepper. Roast for 15-20 minutes. Serve with sautéed zucchini slices.",
               calories: 420),

        // DÍA 3
        Recipe(title: "Spinach and Mushroom Frittata", mealType: .Breakfast, imageName: "lowcarb_frittata",
               ingredients: [
                Ingredient(name: "Eggs", quantity: "4 units"),
                Ingredient(name: "Spinach", quantity: "60g"),
                Ingredient(name: "Mushrooms", quantity: "80g"),
                Ingredient(name: "Onion", quantity: "30g"),
                Ingredient(name: "Goat cheese", quantity: "30g"),
                Ingredient(name: "Olive oil", quantity: "10ml"),
                Ingredient(name: "Heavy cream", quantity: "30ml")
               ],
               instructions: "Preheat oven to 180°C. Sauté diced onions in olive oil until translucent. Add sliced mushrooms and cook until browned. Add spinach and wilt. Whisk eggs with cream, salt, and pepper. Pour over vegetables in an oven-safe skillet. Sprinkle with crumbled goat cheese. Bake for 15-20 minutes until eggs are set.",
               calories: 400),

        Recipe(title: "Shrimp and Avocado Salad", mealType: .Lunch, imageName: "lowcarb_shrimp_avocado",
               ingredients: [
                Ingredient(name: "Shrimp", quantity: "150g"),
                Ingredient(name: "Avocado", quantity: "1 unit"),
                Ingredient(name: "Mixed greens", quantity: "80g"),
                Ingredient(name: "Cherry tomatoes", quantity: "60g"),
                Ingredient(name: "Cucumber", quantity: "50g"),
                Ingredient(name: "Red onion", quantity: "20g"),
                Ingredient(name: "Lime juice", quantity: "15ml"),
                Ingredient(name: "Olive oil", quantity: "10ml"),
                Ingredient(name: "Cilantro", quantity: "5g")
               ],
               instructions: "Cook shrimp until pink and set aside to cool. Combine mixed greens, halved cherry tomatoes, sliced cucumber, and thin red onion slices. Dice avocado and add to salad. Whisk together lime juice, olive oil, chopped cilantro, salt and pepper. Add cooled shrimp to salad and drizzle with dressing.",
               calories: 370),

        Recipe(title: "Herb-Roasted Chicken with Vegetables", mealType: .Dinner, imageName: "lowcarb_roasted_chicken",
               ingredients: [
                Ingredient(name: "Chicken thighs", quantity: "200g"),
                Ingredient(name: "Bell peppers", quantity: "100g"),
                Ingredient(name: "Broccoli", quantity: "100g"),
                Ingredient(name: "Onion", quantity: "50g"),
                Ingredient(name: "Garlic", quantity: "3 cloves"),
                Ingredient(name: "Olive oil", quantity: "15ml"),
                Ingredient(name: "Rosemary", quantity: "3g"),
                Ingredient(name: "Thyme", quantity: "3g")
               ],
               instructions: "Preheat oven to 200°C. Season chicken thighs with salt, pepper, rosemary, and thyme. In a large roasting pan, combine sliced bell peppers, broccoli florets, sliced onion, and whole garlic cloves. Drizzle vegetables with olive oil and season. Place chicken on top and roast for 30-35 minutes until chicken is cooked through and vegetables are tender.",
               calories: 450),

        // DÍA 4
        Recipe(title: "Avocado and Egg Breakfast Bowl", mealType: .Breakfast, imageName: "lowcarb_avocado_egg_bowl",
               ingredients: [
                Ingredient(name: "Eggs", quantity: "2 units"),
                Ingredient(name: "Avocado", quantity: "1 unit"),
                Ingredient(name: "Cherry tomatoes", quantity: "50g"),
                Ingredient(name: "Feta cheese", quantity: "20g"),
                Ingredient(name: "Olive oil", quantity: "5ml"),
                Ingredient(name: "Fresh basil", quantity: "5g"),
                Ingredient(name: "Lemon juice", quantity: "5ml")
               ],
               instructions: "Poach or fry eggs to your preference. Halve and pit avocado, then scoop flesh into a bowl. Mash slightly and season with salt, pepper, and lemon juice. Top with eggs, halved cherry tomatoes, crumbled feta cheese, and torn basil leaves. Drizzle with olive oil.",
               calories: 400),

        Recipe(title: "Tuna Niçoise Salad", mealType: .Lunch, imageName: "lowcarb_tuna_nicoise",
               ingredients: [
                Ingredient(name: "Canned tuna", quantity: "120g"),
                Ingredient(name: "Mixed greens", quantity: "80g"),
                Ingredient(name: "Hard-boiled eggs", quantity: "2 units"),
                Ingredient(name: "Green beans", quantity: "80g"),
                Ingredient(name: "Olives", quantity: "40g"),
                Ingredient(name: "Cherry tomatoes", quantity: "60g"),
                Ingredient(name: "Red onion", quantity: "20g"),
                Ingredient(name: "Olive oil", quantity: "10ml"),
                Ingredient(name: "Dijon mustard", quantity: "5g"),
                Ingredient(name: "Red wine vinegar", quantity: "5ml")
               ],
               instructions: "Steam green beans until tender-crisp, then cool. Arrange mixed greens on a plate. Top with drained tuna, quartered hard-boiled eggs, green beans, olives, halved cherry tomatoes, and thin red onion slices. In a small bowl, whisk together olive oil, Dijon mustard, red wine vinegar, salt, and pepper. Drizzle dressing over salad.",
               calories: 380),

        Recipe(title: "Pork Tenderloin with Roasted Vegetables", mealType: .Dinner, imageName: "lowcarb_pork_vegetables",
               ingredients: [
                Ingredient(name: "Pork tenderloin", quantity: "180g"),
                Ingredient(name: "Zucchini", quantity: "100g"),
                Ingredient(name: "Bell peppers", quantity: "80g"),
                Ingredient(name: "Eggplant", quantity: "80g"),
                Ingredient(name: "Onion", quantity: "50g"),
                Ingredient(name: "Garlic", quantity: "3 cloves"),
                Ingredient(name: "Olive oil", quantity: "15ml"),
                Ingredient(name: "Balsamic vinegar", quantity: "10ml"),
                Ingredient(name: "Fresh herbs (rosemary, thyme)", quantity: "5g")
               ],
               instructions: "Preheat oven to 190°C. Season pork tenderloin with salt, pepper, and chopped herbs. Sear in an oven-safe pan until browned on all sides. Cut zucchini, bell peppers, eggplant, and onion into chunks. Toss vegetables with olive oil, balsamic vinegar, salt, pepper, and crushed garlic. Add to pan around pork. Roast for 20-25 minutes until pork reaches internal temperature of 145°F and vegetables are tender.",
               calories: 400),

        // DÍA 5
        Recipe(title: "Cottage Cheese with Berries", mealType: .Breakfast, imageName: "lowcarb_cottage_berries",
               ingredients: [
                Ingredient(name: "Cottage cheese", quantity: "150g"),
                Ingredient(name: "Mixed berries", quantity: "80g"),
                Ingredient(name: "Walnuts", quantity: "15g"),
                Ingredient(name: "Cinnamon", quantity: "1g"),
                Ingredient(name: "Vanilla extract", quantity: "2ml")
               ],
               instructions: "Place cottage cheese in a bowl. Top with mixed berries and chopped walnuts. Sprinkle with cinnamon and add a few drops of vanilla extract.",
               calories: 280),

        Recipe(title: "Chicken and Vegetable Soup", mealType: .Lunch, imageName: "lowcarb_chicken_soup",
               ingredients: [
                Ingredient(name: "Chicken breast", quantity: "150g"),
                Ingredient(name: "Celery", quantity: "50g"),
                Ingredient(name: "Carrots", quantity: "50g"),
                Ingredient(name: "Onion", quantity: "50g"),
                Ingredient(name: "Garlic", quantity: "2 cloves"),
                Ingredient(name: "Chicken broth", quantity: "500ml"),
                Ingredient(name: "Fresh herbs (parsley, thyme)", quantity: "5g"),
                Ingredient(name: "Olive oil", quantity: "5ml"),
                Ingredient(name: "Spinach", quantity: "30g")
               ],
               instructions: "Heat olive oil in a pot. Sauté diced onion, celery, and carrots until softened. Add minced garlic and cook for 30 seconds. Add chicken broth and bring to a simmer. Add chicken breast and cook until done, about 15-20 minutes. Remove chicken, shred, and return to pot. Stir in spinach and herbs. Season with salt and pepper to taste.",
               calories: 300),

        Recipe(title: "Grilled Steak with Chimichurri", mealType: .Dinner, imageName: "lowcarb_steak_chimichurri",
               ingredients: [
                Ingredient(name: "Sirloin steak", quantity: "180g"),
                Ingredient(name: "Parsley", quantity: "20g"),
                Ingredient(name: "Cilantro", quantity: "10g"),
                Ingredient(name: "Garlic", quantity: "2 cloves"),
                Ingredient(name: "Red wine vinegar", quantity: "15ml"),
                Ingredient(name: "Olive oil", quantity: "20ml"),
                Ingredient(name: "Red pepper flakes", quantity: "1g"),
                Ingredient(name: "Roasted bell peppers", quantity: "100g"),
                Ingredient(name: "Grilled zucchini", quantity: "100g")
               ],
               instructions: "Season steak with salt and pepper. Grill or pan-sear to desired doneness. For chimichurri, finely chop parsley, cilantro, and garlic. Mix with red wine vinegar, olive oil, red pepper flakes, salt, and pepper. Let steak rest for 5 minutes, then slice against the grain. Serve with chimichurri sauce, roasted bell peppers, and grilled zucchini.",
               calories: 480),

        // DÍA 6
        Recipe(title: "Bell Pepper Egg Cups", mealType: .Breakfast, imageName: "lowcarb_pepper_eggs",
               ingredients: [
                Ingredient(name: "Bell peppers", quantity: "2 units"),
                Ingredient(name: "Eggs", quantity: "4 units"),
                Ingredient(name: "Spinach", quantity: "30g"),
                Ingredient(name: "Cheddar cheese", quantity: "30g"),
                Ingredient(name: "Green onions", quantity: "10g"),
                Ingredient(name: "Salt and pepper", quantity: "to taste")
               ],
               instructions: "Preheat oven to 180°C. Cut bell peppers in half lengthwise and remove seeds. Place on a baking sheet. In a bowl, whisk eggs with salt and pepper. Stir in chopped spinach, shredded cheese, and sliced green onions. Pour egg mixture into pepper halves. Bake for 20-25 minutes until eggs are set.",
               calories: 320),

        Recipe(title: "Mediterranean Cauliflower Salad", mealType: .Lunch, imageName: "lowcarb_cauliflower_salad",
               ingredients: [
                Ingredient(name: "Cauliflower", quantity: "150g"),
                Ingredient(name: "Cucumber", quantity: "80g"),
                Ingredient(name: "Cherry tomatoes", quantity: "80g"),
                Ingredient(name: "Red onion", quantity: "30g"),
                Ingredient(name: "Feta cheese", quantity: "40g"),
                Ingredient(name: "Kalamata olives", quantity: "30g"),
                Ingredient(name: "Fresh parsley", quantity: "10g"),
                Ingredient(name: "Olive oil", quantity: "15ml"),
                Ingredient(name: "Lemon juice", quantity: "10ml"),
                Ingredient(name: "Dried oregano", quantity: "2g")
               ],
               instructions: "Break cauliflower into small florets. Steam or microwave until tender-crisp, then cool. Combine cauliflower with diced cucumber, halved cherry tomatoes, diced red onion, crumbled feta, olives, and chopped parsley. In a small bowl, whisk together olive oil, lemon juice, oregano, salt, and pepper. Drizzle over salad and toss to combine.",
               calories: 350),

        Recipe(title: "Garlic Butter Shrimp with Zoodles", mealType: .Dinner, imageName: "lowcarb_shrimp_zoodles",
               ingredients: [
                Ingredient(name: "Shrimp", quantity: "180g"),
                Ingredient(name: "Zucchini", quantity: "200g"),
                Ingredient(name: "Butter", quantity: "20g"),
                Ingredient(name: "Garlic", quantity: "3 cloves"),
                Ingredient(name: "Lemon juice", quantity: "10ml"),
                Ingredient(name: "Red pepper flakes", quantity: "1g"),
                Ingredient(name: "Parsley", quantity: "5g"),
                Ingredient(name: "Parmesan cheese", quantity: "20g")
               ],
               instructions: "Spiralize zucchini into zoodles. Heat half the butter in a large pan. Add minced garlic and cook until fragrant. Add shrimp and cook until pink, about 2-3 minutes per side. Remove shrimp. Add remaining butter to pan. Add zoodles and sauté for 2-3 minutes until tender-crisp. Return shrimp to pan. Add lemon juice, red pepper flakes, and chopped parsley. Toss to combine and serve with grated parmesan.",
               calories: 380),

        // DÍA 7
        Recipe(title: "Chia Pudding with Berries", mealType: .Breakfast, imageName: "lowcarb_chia_pudding",
               ingredients: [
                Ingredient(name: "Chia seeds", quantity: "30g"),
                Ingredient(name: "Unsweetened almond milk", quantity: "200ml"),
                Ingredient(name: "Vanilla extract", quantity: "2ml"),
                Ingredient(name: "Mixed berries", quantity: "80g"),
                Ingredient(name: "Sliced almonds", quantity: "10g")
               ],
               instructions: "In a jar, combine chia seeds, almond milk, and vanilla extract. Stir well. Refrigerate overnight or for at least 4 hours, stirring occasionally. Top with mixed berries and sliced almonds before serving.",
               calories: 250),

        Recipe(title: "Asian-Inspired Lettuce Wraps", mealType: .Lunch, imageName: "lowcarb_asian_wraps",
               ingredients: [
                Ingredient(name: "Ground chicken", quantity: "150g"),
                Ingredient(name: "Water chestnuts", quantity: "40g"),
                Ingredient(name: "Shiitake mushrooms", quantity: "40g"),
                Ingredient(name: "Garlic", quantity: "2 cloves"),
                Ingredient(name: "Ginger", quantity: "5g"),
                Ingredient(name: "Green onions", quantity: "20g"),
                Ingredient(name: "Soy sauce", quantity: "10ml"),
                Ingredient(name: "Rice vinegar", quantity: "5ml"),
                Ingredient(name: "Sesame oil", quantity: "5ml"),
                Ingredient(name: "Lettuce leaves", quantity: "100g")
               ],
               instructions: "Brown ground chicken in a pan. Add minced garlic and ginger, cook until fragrant. Add diced water chestnuts and mushrooms, cook until softened. Stir in chopped green onions, soy sauce, rice vinegar, and sesame oil. Cook for another minute. Serve in lettuce cups.",
               calories: 320),

        Recipe(title: "Stuffed Bell Peppers", mealType: .Dinner, imageName: "lowcarb_stuffed_peppers",
               ingredients: [
                Ingredient(name: "Bell peppers", quantity: "2 units"),
                Ingredient(name: "Ground beef", quantity: "150g"),
                Ingredient(name: "Onion", quantity: "50g"),
                Ingredient(name: "Garlic", quantity: "2 cloves"),
                Ingredient(name: "Tomatoes", quantity: "100g"),
                Ingredient(name: "Zucchini", quantity: "80g"),
                Ingredient(name: "Cheese", quantity: "40g"),
                Ingredient(name: "Olive oil", quantity: "10ml"),
                Ingredient(name: "Italian herbs", quantity: "2g")
               ],
               instructions: "Preheat oven to 190°C. Cut tops off bell peppers and remove seeds. Heat olive oil in a pan. Cook diced onion until translucent. Add minced garlic and cook until fragrant. Add ground beef and cook until browned. Add diced tomatoes, diced zucchini, and Italian herbs. Season with salt and pepper. Cook until vegetables are tender. Fill peppers with mixture and top with cheese. Bake for 25-30 minutes until peppers are tender and cheese is melted.",
               calories: 400)
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
        
        // Separamos las recetas por tipo de comida
        let breakfasts = getRecipes(for: .Breakfast)
        let lunches = getRecipes(for: .Lunch)
        let dinners = getRecipes(for: .Dinner)
        
        // Organizamos por día (asumiendo que tenemos 7 de cada tipo)
        for i in 0..<7 {
            if i < breakfasts.count && i < lunches.count && i < dinners.count {
                result.append([breakfasts[i], lunches[i], dinners[i]])
            }
        }
        
        return result
    }
}
