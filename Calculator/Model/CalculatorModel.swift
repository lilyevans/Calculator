import Foundation

protocol Calculator {
    var result : Double { get }
    
    mutating func performOperation(_ symbol: String) -> Void
    mutating func setOperand(_ operand: Double) -> Void
    mutating func clear() -> Void
}

struct CalculatorModel : Calculator {
    private var accumulator : Double?
    private var pendingBinaryOperation : PendingBinaryOperation?
    private let operations = Operations()
    
    var result : Double {
        get {
            return accumulator!
        }
    }
    
    mutating func performOperation(_ symbol: String) {
        guard let operation = operations.all[symbol] else { return }
        guard let operand = accumulator else { return }
        
        switch operation {
        case .unaryOperation(let function):
            accumulator = function(operand)
        case .binaryOperation(let function):
            handleOperation(operand: operand, operation: function)
        case .equals:
            handleEquals(operand: operand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
        if pendingBinaryOperation != nil && !pendingBinaryOperation!.canComplete {
            pendingBinaryOperation!.operand2 = operand
        }
    }
    
    mutating func clear() {
        pendingBinaryOperation = nil
        accumulator = 0
    }
    
    private mutating func handleOperation(operand : Double, operation : @escaping (Double, Double) -> Double) {
        let operandToEnter : Double
        if pendingBinaryOperation != nil && !pendingBinaryOperation!.completed && pendingBinaryOperation!.canComplete {
            let resultOfPreviousOperation = pendingBinaryOperation!.complete()
            accumulator = resultOfPreviousOperation
            operandToEnter = resultOfPreviousOperation
            
        } else {
            operandToEnter = operand
        }
        
        pendingBinaryOperation = PendingBinaryOperation(operand: operandToEnter, operand2: nil, operation: operation, completed: false)
    }
    
    private mutating func handleEquals(operand: Double) {
        if pendingBinaryOperation != nil {
            if pendingBinaryOperation!.completed {
                pendingBinaryOperation!.operand = accumulator!
                accumulator = pendingBinaryOperation!.complete()
            } else {
                pendingBinaryOperation!.operand2 = operand
                accumulator = pendingBinaryOperation!.complete()
            }
        }
    }
}
