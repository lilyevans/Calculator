import Foundation

class ViewModel {
    private var formatters = DisplayFormatters()
    private var calculator : Calculator
    private var operationToEnter : String?
    private let maxDisplayLength = 9
    private var updateTotalDisplay : (String) -> Void
    private var userIsEnteringDigits : Bool
    private var userHasEnteredDecimal : Bool {
        get {
            return totalForDisplay.contains(".")
        }
    }
    private var numberOfDigitsInDisplay : Int {
        get {
            return totalForDisplay.filter({ $0 != "." && $0 != "," }).count
        }
    }
    
    var totalForDisplay : String {
        didSet {
            updateTotalDisplay(totalForDisplay)
        }
    }
    
    init(updateTotalDisplayFunc : @escaping (String) -> Void, calculator : Calculator) {
        updateTotalDisplay = updateTotalDisplayFunc
        self.calculator = calculator
        
        userIsEnteringDigits = false
        totalForDisplay = "0"
    }
    
    func enterCharacter(_ character : String) {
        if numberOfDigitsInDisplay < maxDisplayLength || !userIsEnteringDigits{
            switch character {
            case "." :
                enterDecimal()
            default :
                enterDigit(character)
            }
        }
    }
    
    func enterOperation(_ symbol : String) {
        if userIsEnteringDigits {
            calculator.setOperand(formatters.transformToDouble(totalForDisplay))
        }
        calculator.performOperation(symbol)
        totalForDisplay = formatters.transformToString(calculator.result)
        userIsEnteringDigits = false
    }
    
    func delete() {
        if userIsEnteringDigits {
            if totalForDisplay.count > 1 {
                var ungrouped = formatters.transformToUngrouped(totalForDisplay)
                ungrouped.removeLast(1)
                totalForDisplay = formatters.transformToString(Double(ungrouped)!)
            } else {
                totalForDisplay = "0"
            }
        }
    }
    
    func clearAll() {
        userIsEnteringDigits = false
        calculator.clear()
        totalForDisplay = "0"
    }
    
    private func enterDigit(_ digit : String) {
        if userIsEnteringDigits {
            if userHasEnteredDecimal {
                totalForDisplay = totalForDisplay + digit
            } else {
                let previousRawString = formatters.transformToUngrouped(totalForDisplay)
                totalForDisplay = formatters.transformToString(Double(previousRawString + digit)!)
            }
        } else {
            totalForDisplay = digit
            userIsEnteringDigits = true
        }
    }
    
    private func enterDecimal() {
        if userIsEnteringDigits {
            if !userHasEnteredDecimal {
                totalForDisplay = totalForDisplay + "."
            }
        } else {
            totalForDisplay = "0."
            userIsEnteringDigits = true
        }
    }
}
