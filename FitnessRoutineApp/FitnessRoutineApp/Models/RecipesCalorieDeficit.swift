import Foundation

struct RecipesDeficit {
    static func getWeeklyRecipes() -> [Recipe] {
        return [
            // DÍA 1
            Recipe(title: "Oatmeal with Berries", mealType: .Breakfast, imageName: "deficit_oatmeal_berries",
                   ingredients: [
                    Ingredient(name: "Oats", quantity: "40g"),
                    Ingredient(name: "Skim milk", quantity: "200ml"),
                    Ingredient(name: "Strawberries", quantity: "50g"),
                    Ingredient(name: "Blueberries", quantity: "30g"),
                    Ingredient(name: "Chia seeds", quantity: "5g")
                   ],
                   instructions: "Cook oats in milk over medium heat. Top with sliced strawberries, blueberries, and chia seeds.",
                   calories: 300),

            Recipe(title: "Grilled Chicken Salad", mealType: .Lunch, imageName: "deficit_chicken_salad",
                   ingredients: [
                    Ingredient(name: "Grilled chicken breast", quantity: "100g"),
                    Ingredient(name: "Mixed greens", quantity: "80g"),
                    Ingredient(name: "Cherry tomatoes", quantity: "50g"),
                    Ingredient(name: "Cucumber", quantity: "50g"),
                    Ingredient(name: "Avocado", quantity: "30g"),
                    Ingredient(name: "Olive oil", quantity: "10ml"),
                    Ingredient(name: "Lemon juice", quantity: "10ml")
                   ],
                   instructions: "Slice all veggies and chicken. Toss everything in a bowl and dress with olive oil and lemon juice.",
                   calories: 400),

            Recipe(title: "Baked Salmon with Broccoli", mealType: .Dinner, imageName: "deficit_salmon_broccoli",
                   ingredients: [
                    Ingredient(name: "Salmon filet", quantity: "120g"),
                    Ingredient(name: "Broccoli", quantity: "100g"),
                    Ingredient(name: "Garlic", quantity: "2 cloves"),
                    Ingredient(name: "Olive oil", quantity: "10ml"),
                    Ingredient(name: "Lemon", quantity: "1/2 unit")
                   ],
                   instructions: "Preheat oven to 180°C. Place salmon and broccoli on baking sheet, drizzle olive oil and crushed garlic, bake for 15–20 minutes. Squeeze lemon on top before serving.",
                   calories: 420),

            // DÍA 2
            Recipe(title: "Greek Yogurt with Nuts & Honey", mealType: .Breakfast, imageName: "deficit_yogurt_nuts",
                   ingredients: [
                    Ingredient(name: "Greek yogurt (low-fat)", quantity: "150g"),
                    Ingredient(name: "Walnuts", quantity: "15g"),
                    Ingredient(name: "Almonds", quantity: "10g"),
                    Ingredient(name: "Honey", quantity: "5g")
                   ],
                   instructions: "Serve yogurt in a bowl. Top with chopped nuts and drizzle with honey.",
                   calories: 320),

            Recipe(title: "Tuna Lettuce Wraps", mealType: .Lunch, imageName: "deficit_tuna_wraps",
                   ingredients: [
                    Ingredient(name: "Canned tuna in water", quantity: "100g"),
                    Ingredient(name: "Lettuce leaves", quantity: "4 large leaves"),
                    Ingredient(name: "Greek yogurt", quantity: "20g"),
                    Ingredient(name: "Celery", quantity: "20g"),
                    Ingredient(name: "Mustard", quantity: "5g"),
                    Ingredient(name: "Black pepper", quantity: "To taste")
                   ],
                   instructions: "Mix tuna, yogurt, mustard, diced celery and pepper. Fill lettuce leaves with mixture and roll.",
                   calories: 330),

            Recipe(title: "Zucchini Noodles with Turkey", mealType: .Dinner, imageName: "deficit_zoodles_turkey",
                   ingredients: [
                    Ingredient(name: "Ground turkey", quantity: "120g"),
                    Ingredient(name: "Zucchini", quantity: "150g"),
                    Ingredient(name: "Tomato sauce (no sugar)", quantity: "50g"),
                    Ingredient(name: "Onion", quantity: "40g"),
                    Ingredient(name: "Garlic", quantity: "1 clove"),
                    Ingredient(name: "Olive oil", quantity: "10ml")
                   ],
                   instructions: "Spiralize zucchini. Cook onion, garlic, and turkey in olive oil. Add tomato sauce and serve over zucchini noodles.",
                   calories: 390),

            // DÍA 3
            Recipe(title: "Boiled Eggs and Whole Wheat Toast", mealType: .Breakfast, imageName: "deficit_eggs_toast",
                   ingredients: [
                    Ingredient(name: "Eggs", quantity: "2 units"),
                    Ingredient(name: "Whole wheat toast", quantity: "1 slice"),
                    Ingredient(name: "Avocado", quantity: "30g"),
                    Ingredient(name: "Salt and pepper", quantity: "To taste")
                   ],
                   instructions: "Boil eggs to desired doneness. Toast bread and spread avocado on top. Serve eggs on side.",
                   calories: 340),

            Recipe(title: "Quinoa Veggie Bowl", mealType: .Lunch, imageName: "deficit_quinoa_veggies",
                   ingredients: [
                    Ingredient(name: "Quinoa (cooked)", quantity: "100g"),
                    Ingredient(name: "Bell peppers", quantity: "50g"),
                    Ingredient(name: "Carrots", quantity: "40g"),
                    Ingredient(name: "Zucchini", quantity: "40g"),
                    Ingredient(name: "Chickpeas", quantity: "60g"),
                    Ingredient(name: "Olive oil", quantity: "10ml")
                   ],
                   instructions: "Sauté vegetables in olive oil. Combine with cooked quinoa and chickpeas.",
                   calories: 410),

            Recipe(title: "Eggplant Lasagna", mealType: .Dinner, imageName: "deficit_eggplant_lasagna",
                   ingredients: [
                    Ingredient(name: "Eggplant", quantity: "150g"),
                    Ingredient(name: "Ground beef (lean)", quantity: "100g"),
                    Ingredient(name: "Tomato sauce", quantity: "50g"),
                    Ingredient(name: "Mozzarella (light)", quantity: "30g"),
                    Ingredient(name: "Basil", quantity: "To taste")
                   ],
                   instructions: "Slice and bake eggplant. Cook beef with tomato sauce. Layer eggplant, meat, and cheese. Bake at 180°C for 15 minutes.",
                   calories: 400),

            // DÍA 4
            Recipe(title: "Smoothie Bowl", mealType: .Breakfast, imageName: "deficit_smoothie_bowl",
                   ingredients: [
                    Ingredient(name: "Frozen berries", quantity: "100g"),
                    Ingredient(name: "Banana", quantity: "1 unit"),
                    Ingredient(name: "Almond milk", quantity: "150ml"),
                    Ingredient(name: "Protein powder", quantity: "15g"),
                    Ingredient(name: "Chia seeds", quantity: "5g")
                   ],
                   instructions: "Blend berries, banana, milk and protein. Pour in bowl and top with chia seeds.",
                   calories: 330),

            Recipe(title: "Turkey Wrap", mealType: .Lunch, imageName: "deficit_turkey_wrap",
                   ingredients: [
                    Ingredient(name: "Whole wheat tortilla", quantity: "1 unit"),
                    Ingredient(name: "Turkey breast slices", quantity: "100g"),
                    Ingredient(name: "Spinach", quantity: "30g"),
                    Ingredient(name: "Tomato", quantity: "30g"),
                    Ingredient(name: "Greek yogurt", quantity: "20g")
                   ],
                   instructions: "Fill tortilla with turkey, spinach, tomato, and yogurt. Wrap and slice in half.",
                   calories: 360),

            Recipe(title: "Shrimp Stir-Fry", mealType: .Dinner, imageName: "deficit_shrimp_stirfry",
                   ingredients: [
                    Ingredient(name: "Shrimp", quantity: "120g"),
                    Ingredient(name: "Bell peppers", quantity: "50g"),
                    Ingredient(name: "Broccoli", quantity: "50g"),
                    Ingredient(name: "Carrots", quantity: "40g"),
                    Ingredient(name: "Soy sauce", quantity: "10ml"),
                    Ingredient(name: "Sesame oil", quantity: "5ml")
                   ],
                   instructions: "Stir-fry shrimp and vegetables in sesame oil. Add soy sauce before serving.",
                   calories: 380),

            // DÍA 5
            Recipe(title: "Avocado Toast with Egg", mealType: .Breakfast, imageName: "deficit_avocado_toast",
                   ingredients: [
                    Ingredient(name: "Whole wheat bread", quantity: "1 slice"),
                    Ingredient(name: "Avocado", quantity: "40g"),
                    Ingredient(name: "Egg", quantity: "1 unit"),
                    Ingredient(name: "Chili flakes", quantity: "To taste")
                   ],
                   instructions: "Toast bread, spread avocado, top with fried or poached egg and sprinkle chili flakes.",
                   calories: 330),

            Recipe(title: "Lentil Soup", mealType: .Lunch, imageName: "deficit_lentil_soup",
                   ingredients: [
                    Ingredient(name: "Lentils", quantity: "100g"),
                    Ingredient(name: "Carrot", quantity: "50g"),
                    Ingredient(name: "Celery", quantity: "40g"),
                    Ingredient(name: "Onion", quantity: "40g"),
                    Ingredient(name: "Olive oil", quantity: "10ml")
                   ],
                   instructions: "Cook all ingredients in water until tender. Blend partially for creamy texture.",
                   calories: 390),

            Recipe(title: "Chicken & Veggie Skewers", mealType: .Dinner, imageName: "deficit_chicken_skewers",
                   ingredients: [
                    Ingredient(name: "Chicken breast", quantity: "100g"),
                    Ingredient(name: "Zucchini", quantity: "50g"),
                    Ingredient(name: "Bell pepper", quantity: "50g"),
                    Ingredient(name: "Onion", quantity: "40g"),
                    Ingredient(name: "Olive oil", quantity: "10ml")
                   ],
                   instructions: "Cube and skewer all ingredients. Grill or bake with olive oil until cooked.",
                   calories: 400),

            // DÍA 6
            Recipe(title: "Cottage Cheese & Pineapple", mealType: .Breakfast, imageName: "deficit_cottage_pineapple",
                   ingredients: [
                    Ingredient(name: "Cottage cheese", quantity: "150g"),
                    Ingredient(name: "Pineapple", quantity: "60g")
                   ],
                   instructions: "Serve cottage cheese in a bowl and top with diced pineapple.",
                   calories: 280),

            Recipe(title: "Chicken Veggie Bowl", mealType: .Lunch, imageName: "deficit_chicken_veggie_bowl",
                   ingredients: [
                    Ingredient(name: "Grilled chicken", quantity: "100g"),
                    Ingredient(name: "Brown rice", quantity: "100g"),
                    Ingredient(name: "Broccoli", quantity: "50g"),
                    Ingredient(name: "Carrots", quantity: "50g"),
                    Ingredient(name: "Sesame seeds", quantity: "5g")
                   ],
                   instructions: "Assemble all ingredients in a bowl. Sprinkle sesame seeds on top.",
                   calories: 420),

            Recipe(title: "Stuffed Bell Peppers", mealType: .Dinner, imageName: "deficit_stuffed_peppers",
                   ingredients: [
                    Ingredient(name: "Bell peppers", quantity: "2 units"),
                    Ingredient(name: "Ground chicken", quantity: "120g"),
                    Ingredient(name: "Brown rice (cooked)", quantity: "80g"),
                    Ingredient(name: "Tomato sauce", quantity: "60g"),
                    Ingredient(name: "Onion", quantity: "40g"),
                    Ingredient(name: "Garlic", quantity: "2 cloves"),
                    Ingredient(name: "Cheese (light)", quantity: "30g")
                   ],
                   instructions: "Cut tops off bell peppers and remove seeds. Sauté onion and garlic, then add chicken. Stir in rice and sauce. Stuff peppers, top with cheese and bake.",
                   calories: 390),

            // DÍA 7
            Recipe(title: "Protein Pancakes", mealType: .Breakfast, imageName: "deficit_protein_pancakes",
                   ingredients: [
                    Ingredient(name: "Oats", quantity: "40g"),
                    Ingredient(name: "Banana", quantity: "1 small"),
                    Ingredient(name: "Eggs", quantity: "1 unit"),
                    Ingredient(name: "Egg whites", quantity: "2 units"),
                    Ingredient(name: "Protein powder", quantity: "15g"),
                    Ingredient(name: "Baking powder", quantity: "2g"),
                    Ingredient(name: "Cinnamon", quantity: "1g")
                   ],
                   instructions: "Blend all ingredients. Cook pancakes on a non-stick pan until golden.",
                   calories: 350),

            Recipe(title: "Grilled Veggie & Hummus Plate", mealType: .Lunch, imageName: "deficit_veggie_plate",
                   ingredients: [
                    Ingredient(name: "Zucchini", quantity: "100g"),
                    Ingredient(name: "Eggplant", quantity: "100g"),
                    Ingredient(name: "Bell peppers", quantity: "80g"),
                    Ingredient(name: "Hummus", quantity: "50g"),
                    Ingredient(name: "Whole wheat pita bread", quantity: "1/2 unit"),
                    Ingredient(name: "Olive oil", quantity: "10ml"),
                    Ingredient(name: "Lemon juice", quantity: "10ml")
                   ],
                   instructions: "Grill veggies. Serve with hummus and half pita. Drizzle with olive oil and lemon juice.",
                   calories: 380),

            Recipe(title: "Beef Stir-Fry with Cauliflower Rice", mealType: .Dinner, imageName: "deficit_beef_stirfry",
                   ingredients: [
                    Ingredient(name: "Beef strips (lean)", quantity: "120g"),
                    Ingredient(name: "Cauliflower rice", quantity: "150g"),
                    Ingredient(name: "Broccoli", quantity: "80g"),
                    Ingredient(name: "Carrots", quantity: "60g"),
                    Ingredient(name: "Garlic", quantity: "2 cloves"),
                    Ingredient(name: "Soy sauce (low sodium)", quantity: "15ml"),
                    Ingredient(name: "Sesame oil", quantity: "5ml")
                   ],
                   instructions: "Sauté garlic in oil. Add beef, then vegetables. Stir-fry and finish with soy sauce.",
                   calories: 400)
        ]
    }
}
