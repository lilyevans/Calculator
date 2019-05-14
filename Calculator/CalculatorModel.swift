import Foundation

struct PendingBinaryOperation {
    var operand : Double
    var operation : (Double, Double) -> Double
    var completed : Bool
    
    mutating func complete(withOperand operand2 : Double) -> Double {
        let result = operation(operand, operand2)
        completed = true
        operand = operand2
        
        return result
    }
}


protocol Calculator {
    var result : Double { get }
    
    mutating func performOperation(_ symbol: String) -> Void
    mutating func setOperand(_ operand: Double) -> Void
    mutating func clear() -> Void
}

struct CalculatorModel : Calculator, HasOperations {
    private var accumulator : Double?
    private var pendingBinaryOperation : PendingBinaryOperation?
    var operations = Operations()
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
            if pendingBinaryOperation != nil && !pendingBinaryOperation!.completed {
                let resultOfPreviousOperation = pendingBinaryOperation!.complete(withOperand: operand)
                accumulator = resultOfPreviousOperation
                pendingBinaryOperation!.operand = resultOfPreviousOperation
                pendingBinaryOperation!.operation = function
            } else {
                pendingBinaryOperation = PendingBinaryOperation(operand: operand, operation: function, completed: false)
            }
        case .equals:
            if pendingBinaryOperation != nil {
                if pendingBinaryOperation!.completed {
                    let previosOperand = pendingBinaryOperation!.operand
                    pendingBinaryOperation!.operand = accumulator!
                    accumulator = pendingBinaryOperation!.complete(withOperand: previosOperand)
                    pendingBinaryOperation!.operand = previosOperand
                } else {
                    accumulator = pendingBinaryOperation!.complete(withOperand: operand)
                }
                
            }
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    mutating func clear() {
        pendingBinaryOperation = nil
        accumulator = 0
    }
}
