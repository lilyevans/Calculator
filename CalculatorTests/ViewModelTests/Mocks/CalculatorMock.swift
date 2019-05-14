import Foundation
@testable import Calculator

class CalculatorMock : Calculator {
    var numberToReturn = Double(23.0)
    var result: Double {
        get {
            return numberToReturn
        }
    }
    var getWasCalledOnResult = false
    var performOperationCalledWith : [String] = []
    var setOperandCalledWith : [Double] = []
    var clearWasCalled = false
    
    func performOperation(_ symbol: String) {
        performOperationCalledWith.append(symbol)
    }
    
    func setOperand(_ operand: Double) {
        setOperandCalledWith.append(operand)
    }
    
    func clear() {
        numberToReturn = 0
        clearWasCalled = true
    }
}
