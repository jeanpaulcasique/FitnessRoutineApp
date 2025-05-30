import Foundation

struct QuantityParser {
    static func combine(_ quantities: [String]) -> String {
        guard let regex = try? NSRegularExpression(pattern: #"([0-9]*\.?[0-9]+)\s*(\w+)"#, options: []) else {
            return quantities.joined(separator: " + ")
        }

        var total: Double = 0
        var unit: String?

        for quantity in quantities {
            let range = NSRange(quantity.startIndex..., in: quantity)

            guard let match = regex.firstMatch(in: quantity, options: [], range: range),
                  let numberRange = Range(match.range(at: 1), in: quantity),
                  let unitRange = Range(match.range(at: 2), in: quantity) else {
                // Retorna suma textual si falla el parseo de alguna entrada
                return quantities.joined(separator: " + ")
            }

            let number = Double(quantity[numberRange]) ?? 0
            let parsedUnit = quantity[unitRange].trimmingCharacters(in: .whitespaces)

            if unit == nil {
                unit = parsedUnit
            } else if unit != parsedUnit {
                return quantities.joined(separator: " + ")
            }

            total += number
        }

        guard let u = unit else {
            return quantities.joined(separator: " + ")
        }

        // Formatea con 1 decimal si no es número entero
        return total.truncatingRemainder(dividingBy: 1) == 0 ?
            "\(Int(total))\(u)" : String(format: "%.1f%@", total, u)
    }
}
