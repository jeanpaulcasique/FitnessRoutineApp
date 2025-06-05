
import Foundation

// MARK: - Sistema de Conversión de Cantidades para Lista de Compras

struct GroceryUnit {
    let name: String
    let averageWeight: Double // en gramos
    let unit: String
}

class GroceryConverter {
    
    // MARK: - Base de datos de productos comunes
    private static let productDatabase: [String: GroceryUnit] = [
        // Verduras
        "berenjena": GroceryUnit(name: "berenjena", averageWeight: 250, unit: "unidad"),
        "tomate": GroceryUnit(name: "tomate", averageWeight: 150, unit: "unidad"),
        "cebolla": GroceryUnit(name: "cebolla", averageWeight: 150, unit: "unidad"),
        "pimiento": GroceryUnit(name: "pimiento", averageWeight: 200, unit: "unidad"),
        "zanahoria": GroceryUnit(name: "zanahoria", averageWeight: 100, unit: "unidad"),
        "calabacín": GroceryUnit(name: "calabacín", averageWeight: 200, unit: "unidad"),
        "brócoli": GroceryUnit(name: "brócoli", averageWeight: 300, unit: "unidad"),
        "coliflor": GroceryUnit(name: "coliflor", averageWeight: 600, unit: "unidad"),
        "espinacas": GroceryUnit(name: "espinacas", averageWeight: 250, unit: "bolsa"),
        "lechuga": GroceryUnit(name: "lechuga", averageWeight: 300, unit: "unidad"),
        "pepino": GroceryUnit(name: "pepino", averageWeight: 300, unit: "unidad"),
        "ajo": GroceryUnit(name: "ajo", averageWeight: 40, unit: "cabeza"),
        "patata": GroceryUnit(name: "patata", averageWeight: 200, unit: "unidad"),
        "batata": GroceryUnit(name: "batata", averageWeight: 250, unit: "unidad"),
        
        // Frutas
        "manzana": GroceryUnit(name: "manzana", averageWeight: 180, unit: "unidad"),
        "plátano": GroceryUnit(name: "plátano", averageWeight: 120, unit: "unidad"),
        "naranja": GroceryUnit(name: "naranja", averageWeight: 200, unit: "unidad"),
        "limón": GroceryUnit(name: "limón", averageWeight: 60, unit: "unidad"),
        "aguacate": GroceryUnit(name: "aguacate", averageWeight: 200, unit: "unidad"),
        "fresa": GroceryUnit(name: "fresa", averageWeight: 250, unit: "bandeja"),
        "arándanos": GroceryUnit(name: "arándanos", averageWeight: 125, unit: "bandeja"),
        "kiwi": GroceryUnit(name: "kiwi", averageWeight: 90, unit: "unidad"),
        "pera": GroceryUnit(name: "pera", averageWeight: 180, unit: "unidad"),
        "melocotón": GroceryUnit(name: "melocotón", averageWeight: 150, unit: "unidad"),
        "piña": GroceryUnit(name: "piña", averageWeight: 1000, unit: "unidad"),
        "melón": GroceryUnit(name: "melón", averageWeight: 1500, unit: "unidad"),
        "sandía": GroceryUnit(name: "sandía", averageWeight: 3000, unit: "unidad"),
        
        // Proteínas
        "pollo": GroceryUnit(name: "pollo", averageWeight: 150, unit: "pechuga"),
        "pechuga de pollo": GroceryUnit(name: "pechuga de pollo", averageWeight: 150, unit: "unidad"),
        "muslo de pollo": GroceryUnit(name: "muslo de pollo", averageWeight: 100, unit: "unidad"),
        "carne picada": GroceryUnit(name: "carne picada", averageWeight: 500, unit: "bandeja"),
        "ternera": GroceryUnit(name: "ternera", averageWeight: 200, unit: "filete"),
        "cerdo": GroceryUnit(name: "cerdo", averageWeight: 150, unit: "filete"),
        "salmón": GroceryUnit(name: "salmón", averageWeight: 150, unit: "filete"),
        "atún": GroceryUnit(name: "atún", averageWeight: 150, unit: "filete"),
        "merluza": GroceryUnit(name: "merluza", averageWeight: 150, unit: "filete"),
        "lubina": GroceryUnit(name: "lubina", averageWeight: 300, unit: "unidad"),
        "huevo": GroceryUnit(name: "huevo", averageWeight: 60, unit: "unidad"),
        "huevos": GroceryUnit(name: "huevos", averageWeight: 60, unit: "unidad"),
        
        // Lácteos
        "leche": GroceryUnit(name: "leche", averageWeight: 1000, unit: "litro"),
        "yogur": GroceryUnit(name: "yogur", averageWeight: 125, unit: "unidad"),
        "queso": GroceryUnit(name: "queso", averageWeight: 200, unit: "paquete"),
        "mantequilla": GroceryUnit(name: "mantequilla", averageWeight: 250, unit: "paquete"),
        
        // Granos y cereales
        "arroz": GroceryUnit(name: "arroz", averageWeight: 1000, unit: "paquete"),
        "pasta": GroceryUnit(name: "pasta", averageWeight: 500, unit: "paquete"),
        "pan": GroceryUnit(name: "pan", averageWeight: 400, unit: "barra"),
        "avena": GroceryUnit(name: "avena", averageWeight: 500, unit: "paquete"),
        "quinoa": GroceryUnit(name: "quinoa", averageWeight: 500, unit: "paquete"),
        
        // Legumbres
        "lentejas": GroceryUnit(name: "lentejas", averageWeight: 500, unit: "paquete"),
        "garbanzos": GroceryUnit(name: "garbanzos", averageWeight: 500, unit: "paquete"),
        "judías": GroceryUnit(name: "judías", averageWeight: 500, unit: "paquete"),
        "alubias": GroceryUnit(name: "alubias", averageWeight: 500, unit: "paquete"),
        
        // Frutos secos
        "almendras": GroceryUnit(name: "almendras", averageWeight: 200, unit: "bolsa"),
        "nueces": GroceryUnit(name: "nueces", averageWeight: 200, unit: "bolsa"),
        "cacahuetes": GroceryUnit(name: "cacahuetes", averageWeight: 200, unit: "bolsa"),
        "anacardos": GroceryUnit(name: "anacardos", averageWeight: 200, unit: "bolsa"),
        
        // Condimentos y aceites
        "aceite de oliva": GroceryUnit(name: "aceite de oliva", averageWeight: 1000, unit: "botella"),
        "vinagre": GroceryUnit(name: "vinagre", averageWeight: 500, unit: "botella"),
        "sal": GroceryUnit(name: "sal", averageWeight: 1000, unit: "paquete"),
        "pimienta": GroceryUnit(name: "pimienta", averageWeight: 100, unit: "bote"),
        "orégano": GroceryUnit(name: "orégano", averageWeight: 50, unit: "bote"),
        "pimentón": GroceryUnit(name: "pimentón", averageWeight: 75, unit: "bote"),
        "comino": GroceryUnit(name: "comino", averageWeight: 50, unit: "bote"),
        "curry": GroceryUnit(name: "curry", averageWeight: 50, unit: "bote"),
        "jengibre": GroceryUnit(name: "jengibre", averageWeight: 100, unit: "raíz"),
        "canela": GroceryUnit(name: "canela", averageWeight: 50, unit: "bote"),
        "miel": GroceryUnit(name: "miel", averageWeight: 500, unit: "bote"),
        "mostaza": GroceryUnit(name: "mostaza", averageWeight: 200, unit: "bote"),
        "mayonesa": GroceryUnit(name: "mayonesa", averageWeight: 450, unit: "bote"),
        "ketchup": GroceryUnit(name: "ketchup", averageWeight: 450, unit: "bote"),
        "salsa de soja": GroceryUnit(name: "salsa de soja", averageWeight: 250, unit: "botella"),
        
        // Otros
        "harina": GroceryUnit(name: "harina", averageWeight: 1000, unit: "paquete"),
        "azúcar": GroceryUnit(name: "azúcar", averageWeight: 1000, unit: "paquete"),
        "chocolate": GroceryUnit(name: "chocolate", averageWeight: 100, unit: "tableta"),
        "café": GroceryUnit(name: "café", averageWeight: 250, unit: "paquete"),
        "té": GroceryUnit(name: "té", averageWeight: 100, unit: "caja")
    ]
    
    // MARK: - Conversión de cantidades a unidades de compra
    
    static func convertToGroceryUnit(ingredient: Ingredient) -> Ingredient {
        let normalizedName = normalizeIngredientName(ingredient.name)
        
        // Intentar parsear la cantidad actual
        let (quantity, unit) = QuantityParser.parseQuantity(ingredient.quantity)
        
        // Si ya está en unidades naturales, mantenerlo
        if isNaturalUnit(unit) && quantity == Double(Int(quantity)) {
            return ingredient
        }
        
        // Buscar en la base de datos
        if let productInfo = findProductInfo(for: normalizedName) {
            // Convertir gramos a unidades
            if unit == "g" || unit == "gr" || unit == "gramos" {
                let units = calculateUnits(grams: quantity, productInfo: productInfo)
                let newQuantity = formatGroceryQuantity(units: units, productInfo: productInfo)
                
                return Ingredient(
                    name: ingredient.name,
                    quantity: newQuantity,
                    isChecked: ingredient.isChecked
                )
            }
            // Convertir kg a unidades
            else if unit == "kg" || unit == "kilos" {
                let grams = quantity * 1000
                let units = calculateUnits(grams: grams, productInfo: productInfo)
                let newQuantity = formatGroceryQuantity(units: units, productInfo: productInfo)
                
                return Ingredient(
                    name: ingredient.name,
                    quantity: newQuantity,
                    isChecked: ingredient.isChecked
                )
            }
            // Convertir ml a unidades para líquidos
            else if unit == "ml" || unit == "l" {
                let ml = unit == "l" ? quantity * 1000 : quantity
                return convertLiquid(ingredient: ingredient, ml: ml)
            }
        }
        
        // Si no se puede convertir, simplificar la cantidad si es posible
        return simplifyQuantity(ingredient: ingredient)
    }
    
    // MARK: - Métodos auxiliares privados
    
    private static func normalizeIngredientName(_ name: String) -> String {
        return name.lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "de ", with: "")
            .replacingOccurrences(of: "en ", with: "")
            .replacingOccurrences(of: "al ", with: "")
            .replacingOccurrences(of: "a la ", with: "")
            .replacingOccurrences(of: "con ", with: "")
    }
    
    private static func findProductInfo(for name: String) -> GroceryUnit? {
        // Búsqueda exacta
        if let exact = productDatabase[name] {
            return exact
        }
        
        // Búsqueda parcial
        for (key, value) in productDatabase {
            if name.contains(key) || key.contains(name) {
                return value
            }
        }
        
        return nil
    }
    
    private static func calculateUnits(grams: Double, productInfo: GroceryUnit) -> Double {
        return grams / productInfo.averageWeight
    }
    
    private static func formatGroceryQuantity(units: Double, productInfo: GroceryUnit) -> String {
        // Redondear a cantidades prácticas
        let roundedUnits: Double
        
        if units < 0.5 {
            roundedUnits = 0.5
        } else if units < 1.0 {
            roundedUnits = 1.0
        } else if units < 2.0 {
            roundedUnits = ceil(units)
        } else {
            roundedUnits = round(units)
        }
        
        // Formatear la salida
        if roundedUnits == 0.5 {
            return "1/2 \(productInfo.unit)"
        } else if roundedUnits == 1.0 {
            return "1 \(productInfo.unit)"
        } else if roundedUnits == Double(Int(roundedUnits)) {
            return "\(Int(roundedUnits)) \(productInfo.unit)\(roundedUnits > 1 ? "s" : "")"
        } else {
            return String(format: "%.1f \(productInfo.unit)s", roundedUnits)
        }
    }
    
    private static func isNaturalUnit(_ unit: String) -> Bool {
        let naturalUnits = ["unidad", "unidades", "pechuga", "pechugas", "filete", "filetes",
                           "barra", "barras", "paquete", "paquetes", "bolsa", "bolsas",
                           "bandeja", "bandejas", "litro", "litros", "botella", "botellas",
                           "bote", "botes", "tableta", "tabletas", "cabeza", "cabezas",
                           "manojo", "manojos", "rama", "ramas", "taza", "tazas",
                           "cucharada", "cucharadas", "cucharadita", "cucharaditas"]
        
        return naturalUnits.contains(unit.lowercased())
    }
    
    private static func convertLiquid(ingredient: Ingredient, ml: Double) -> Ingredient {
        let liters = ml / 1000
        
        if liters <= 0.5 {
            return Ingredient(
                name: ingredient.name,
                quantity: "\(Int(ml)) ml",
                isChecked: ingredient.isChecked
            )
        } else if liters == 1.0 {
            return Ingredient(
                name: ingredient.name,
                quantity: "1 litro",
                isChecked: ingredient.isChecked
            )
        } else {
            return Ingredient(
                name: ingredient.name,
                quantity: String(format: "%.1f litros", liters),
                isChecked: ingredient.isChecked
            )
        }
    }
    
    private static func simplifyQuantity(ingredient: Ingredient) -> Ingredient {
        let (quantity, unit) = QuantityParser.parseQuantity(ingredient.quantity)
        
        // Simplificar cantidades muy pequeñas
        if quantity < 10 && (unit == "g" || unit == "gr" || unit == "ml") {
            return Ingredient(
                name: ingredient.name,
                quantity: "al gusto",
                isChecked: ingredient.isChecked
            )
        }
        
        // Redondear a números más simples
        let simplified: String
        if quantity >= 1000 && (unit == "g" || unit == "gr") {
            simplified = String(format: "%.1f kg", quantity / 1000)
        } else if quantity >= 1000 && unit == "ml" {
            simplified = String(format: "%.1f L", quantity / 1000)
        } else {
            simplified = ingredient.quantity
        }
        
        return Ingredient(
            name: ingredient.name,
            quantity: simplified,
            isChecked: ingredient.isChecked
        )
    }
}

// MARK: - Extensión para DietViewModel

extension DietViewModel {
    
    // Sobrescribir el método updateGroceryList para usar el convertidor
    func updateGroceryListWithConversion() {
        let allIngredients = weeklyRecipes.values.flatMap { $0 }.flatMap { $0.ingredients }
        let checked = loadCheckedIngredientNames()
        
        // Agrupar ingredientes por nombre
        let grouped = Dictionary(grouping: allIngredients, by: { $0.name })
        
        let convertedIngredients = grouped.map { name, items -> Ingredient in
            // Combinar cantidades
            let combinedQuantity = QuantityParser.combine(items.map { $0.quantity })
            let tempIngredient = Ingredient(name: name, quantity: combinedQuantity, isChecked: checked.contains(name))
            
            // Convertir a unidades de compra
            return GroceryConverter.convertToGroceryUnit(ingredient: tempIngredient)
        }
        
        groceryList = convertedIngredients.sorted { $0.name < $1.name }
    }
}

// MARK: - Extensión mejorada de QuantityParser para combinar cantidades

extension QuantityParser {
    static func combine(_ quantities: [String]) -> String {
        guard !quantities.isEmpty else { return "0" }
        
        var totalByUnit: [String: Double] = [:]
        
        for quantity in quantities {
            let (value, unit) = parseQuantity(quantity)
            let normalizedUnit = normalizeUnit(unit)
            
            if let existing = totalByUnit[normalizedUnit] {
                totalByUnit[normalizedUnit] = existing + value
            } else {
                totalByUnit[normalizedUnit] = value
            }
        }
        
        // Si hay múltiples unidades, convertir todo a la unidad más común
        if totalByUnit.count > 1 {
            return convertToCommonUnit(totalByUnit)
        }
        
        // Si solo hay una unidad, formatear el resultado
        if let (unit, total) = totalByUnit.first {
            return formatQuantity(total, unit: unit)
        }
        
        return "0"
    }
    
    private static func normalizeUnit(_ unit: String) -> String {
        let unitMappings: [String: String] = [
            "g": "g",
            "gr": "g",
            "gramos": "g",
            "gramo": "g",
            "kg": "kg",
            "kilo": "kg",
            "kilos": "kg",
            "kilogramo": "kg",
            "kilogramos": "kg",
            "ml": "ml",
            "mililitro": "ml",
            "mililitros": "ml",
            "l": "l",
            "litro": "l",
            "litros": "l",
            "taza": "taza",
            "tazas": "taza",
            "cucharada": "cucharada",
            "cucharadas": "cucharada",
            "cucharadita": "cucharadita",
            "cucharaditas": "cucharadita",
            "unidad": "unidad",
            "unidades": "unidad"
        ]
        
        return unitMappings[unit.lowercased()] ?? unit
    }
    
    private static func convertToCommonUnit(_ units: [String: Double]) -> String {
        var totalGrams: Double = 0
        var totalMl: Double = 0
        var hasOtherUnits = false
        
        for (unit, value) in units {
            switch unit {
            case "g":
                totalGrams += value
            case "kg":
                totalGrams += value * 1000
            case "ml":
                totalMl += value
            case "l":
                totalMl += value * 1000
            default:
                hasOtherUnits = true
            }
        }
        
        // Si hay unidades mezcladas, devolver la más significativa
        if totalGrams > 0 && totalMl == 0 && !hasOtherUnits {
            if totalGrams >= 1000 {
                return formatQuantity(totalGrams / 1000, unit: "kg")
            } else {
                return formatQuantity(totalGrams, unit: "g")
            }
        }
        
        if totalMl > 0 && totalGrams == 0 && !hasOtherUnits {
            if totalMl >= 1000 {
                return formatQuantity(totalMl / 1000, unit: "l")
            } else {
                return formatQuantity(totalMl, unit: "ml")
            }
        }
        
        // Si hay mezcla de unidades, devolver la primera encontrada
        if let (unit, value) = units.first {
            return formatQuantity(value, unit: unit)
        }
        
        return "0"
    }
}
