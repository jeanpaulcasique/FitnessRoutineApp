import SwiftUI
import Combine
import Network

final class DietTypeViewModel: ObservableObject {
    @Published var currentIndex = 0
    @Published var isNextButtonDisabled = false
    @Published var isLoading = false
    @Published var isOffline = false
    @Published private(set) var isDataReady = false
    
    private var cancellables = Set<AnyCancellable>()
    private let networkMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    let imageCount = 4
    let imageNames = ["balanced", "lowCarb", "highProtein", "vegetarian"]
    let titles = ["Balanced", "Low Carb", "High Protein", "Vegetarian"]
    
    let shortDescriptions = [
        "Perfect balance of nutrients",
        "Reduced carbohydrate intake",
        "Focus on protein-rich foods",
        "Plant-based nutrition"
    ]
    
    let detailedDescriptions = [
        "A well-rounded approach with balanced macronutrients",
        "Emphasis on proteins and fats, limited carbs",
        "Higher protein intake for muscle growth",
        "Plant-based foods with no meat"
    ]
    
    private var dietDetailsCache: [Int: DietDetails] = [:]
    
    init() {
        setupNetworkMonitoring()
        loadCachedData()
        initializeData()
    }
    
    private func initializeData() {
        for index in 0..<imageCount {
            dietDetailsCache[index] = createDietDetails(for: index)
        }
        isDataReady = true
        saveCacheData()
    }
    
    private func setupNetworkMonitoring() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isOffline = path.status != .satisfied
            }
        }
        networkMonitor.start(queue: queue)
    }
    
    private func loadCachedData() {
        if let cached = UserDefaults.standard.object(forKey: "DietDetailsCache") as? Data {
            if let decoded = try? JSONDecoder().decode([Int: DietDetails].self, from: cached) {
                dietDetailsCache = decoded
                isDataReady = true
            }
        }
    }
    
    private func saveCacheData() {
        if let encoded = try? JSONEncoder().encode(dietDetailsCache) {
            UserDefaults.standard.set(encoded, forKey: "DietDetailsCache")
        }
    }
    
    func checkConnectivity() {
        isOffline = networkMonitor.currentPath.status != .satisfied
    }
    
    func selectDiet(_ index: Int) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            currentIndex = index
            isNextButtonDisabled = false
        }
    }
    
    func getDietDetails(for index: Int) -> DietDetails? {
        if !isDataReady {
            initializeData()
        }
        return dietDetailsCache[index]
    }
    
    private func createDietDetails(for index: Int) -> DietDetails {
        let macros: [MacroNutrient]
        let benefits: [String]
        let recommendations: [String]
        
        switch index {
        case 0: // Balanced
            macros = [
                MacroNutrient(name: "Protein", percentage: 30),
                MacroNutrient(name: "Carbs", percentage: 40),
                MacroNutrient(name: "Fats", percentage: 30)
            ]
            benefits = [
                "Sustainable long-term approach",
                "Supports overall health",
                "Flexible meal planning",
                "Good for weight management"
            ]
            recommendations = [
                "Lean meats and fish",
                "Whole grains",
                "Fruits and vegetables",
                "Healthy fats"
            ]
            
        case 1: // Low Carb
            macros = [
                MacroNutrient(name: "Protein", percentage: 35),
                MacroNutrient(name: "Carbs", percentage: 25),
                MacroNutrient(name: "Fats", percentage: 40)
            ]
            benefits = [
                "Effective for weight loss",
                "May improve insulin sensitivity",
                "Reduces sugar cravings",
                "Stable energy levels"
            ]
            recommendations = [
                "Meat and fish",
                "Low-carb vegetables",
                "Eggs and dairy",
                "Nuts and seeds"
            ]
            
        case 2: // High Protein
            macros = [
                MacroNutrient(name: "Protein", percentage: 45),
                MacroNutrient(name: "Carbs", percentage: 35),
                MacroNutrient(name: "Fats", percentage: 20)
            ]
            benefits = [
                "Supports muscle growth",
                "Enhanced recovery",
                "Increased satiety",
                "Preserves lean mass"
            ]
            recommendations = [
                "Lean meats",
                "Fish and seafood",
                "Greek yogurt",
                "Protein supplements"
            ]
            
        case 3: // Vegetarian
            macros = [
                MacroNutrient(name: "Protein", percentage: 25),
                MacroNutrient(name: "Carbs", percentage: 50),
                MacroNutrient(name: "Fats", percentage: 25)
            ]
            benefits = [
                "Environmental friendly",
                "Rich in fiber",
                "Lower cholesterol",
                "Heart healthy"
            ]
            recommendations = [
                "Legumes and beans",
                "Nuts and seeds",
                "Plant-based proteins",
                "Whole grains"
            ]
            
        default:
            macros = []
            benefits = []
            recommendations = []
        }
        
        return DietDetails(
            macroNutrients: macros,
            benefits: benefits,
            recommendations: recommendations
        )
    }
    
    func disableNextButtonTemporarily() {
        isNextButtonDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.isNextButtonDisabled = false
        }
    }
    
    deinit {
        networkMonitor.cancel()
    }
}

struct MacroNutrient: Codable {
    let name: String
    let percentage: Int
}

struct DietDetails: Codable {
    let macroNutrients: [MacroNutrient]
    let benefits: [String]
    let recommendations: [String]
} 