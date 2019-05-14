import Foundation

struct DisplayFormatters {
    private var standard : NumberFormatter {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 9
            formatter.notANumberSymbol = "Error"
            formatter.positiveInfinitySymbol = "Error"
            formatter.negativeInfinitySymbol = "Error"
            
            return formatter
        }
    }
    private var ungrouped : NumberFormatter {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 9
            formatter.notANumberSymbol = "Error"
            formatter.positiveInfinitySymbol = "Error"
            formatter.negativeInfinitySymbol = "Error"
            formatter.usesGroupingSeparator = false
            
            return formatter
        }
    }
    private var scientific : NumberFormatter {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .scientific
            formatter.maximumIntegerDigits = 9
            formatter.maximumFractionDigits = 5
            formatter.notANumberSymbol = "Error"
            formatter.positiveInfinitySymbol = "Error"
            formatter.negativeInfinitySymbol = "Error"
            
            return formatter
        }
    }
    
    func transformToUngrouped(_ groupedString : String) -> String {
        let number = standard.number(from: groupedString)!
        return ungrouped.string(from: number)!
    }
    
    func transformToDouble(_ standardNumberString : String) -> Double {
        let number = standard.number(from: standardNumberString)!
        return Double(truncating: number)
    }
    
    func transformToString(_ number : Double) -> String  {
        let stringFromDouble = standard.string(from: NSNumber(value: number))!
        if stringFromDouble.filter({ $0 != "." && $0 != ","}).count < 10 {
            return stringFromDouble
        }
        return scientific.string(from: NSNumber(value: number))!.lowercased()
    }
}
