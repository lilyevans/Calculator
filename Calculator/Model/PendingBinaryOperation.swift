import Foundation

struct PendingBinaryOperation {
    var operand : Double
    var operand2 : Double?
    var operation : (Double, Double) -> Double
    var completed : Bool
    var canComplete : Bool {
        get {
            return operand2 != nil
        }
    }
    
    mutating func complete() -> Double {
        let result = operation(operand, operand2!)
        completed = true
        
        return result
    }
}
