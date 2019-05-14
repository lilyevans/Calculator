import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {
    var calculator = CalculatorModel()
    
    override func setUp() {
        calculator = CalculatorModel()
    }
    
    func testPerformsPendingOperationWhenDigitAndSubsequentOperationEntered() {
        let firstNumber = 9.0
        let secondNumber = 1.0
        let thirdNumber = 11.0
        
        calculator.setOperand(firstNumber)
        calculator.performOperation("+")
        calculator.setOperand(secondNumber)
        calculator.performOperation("×")
        
        var expectedResult = firstNumber + secondNumber
        XCTAssert(calculator.result == expectedResult)
        
        calculator.setOperand(thirdNumber)
        calculator.performOperation("=")
        
        expectedResult = expectedResult * thirdNumber
        XCTAssert(calculator.result == expectedResult)
    }
    
    func testRepeatsLastOperationWithSubsequentEquals() {
        var expectedResult : Double
        
        let firstNumber = 6.0
        let secondNumber = 3.0
        let thirdNumber = 4.0
        
        calculator.setOperand(firstNumber)
        calculator.performOperation("+")
        calculator.setOperand(secondNumber)
        calculator.performOperation("=")
        calculator.performOperation("=")
        
        expectedResult = firstNumber + secondNumber + secondNumber
        XCTAssert(calculator.result == expectedResult)
        
        calculator.performOperation("+")
        XCTAssert(calculator.result == expectedResult)
        
        calculator.setOperand(thirdNumber)
        calculator.performOperation("=")
        
        expectedResult = expectedResult + thirdNumber
        XCTAssert(calculator.result == expectedResult)
    }
    
    func testOnlyPerformsLastOfOperatorsEnteredWithNoDigits() {
        let firstNumber = 6.0
        let secondNumber = 3.0
        
        calculator.setOperand(firstNumber)
        
        calculator.performOperation("+")
        calculator.performOperation("-")
        
        calculator.setOperand(secondNumber)
        calculator.performOperation("=")
        
        let expectedResult = firstNumber - secondNumber
        XCTAssert(calculator.result == expectedResult)
    }
    
    func testClearsCalculator() {
        let firstNumber = 6.0
        let secondNumber = 3.0
        
        calculator.setOperand(firstNumber)
        calculator.performOperation("+")
        
        calculator.clear()
        XCTAssert(calculator.result == 0)
        
        calculator.performOperation("+")
        XCTAssert(calculator.result == 0)
        
        calculator.setOperand(secondNumber)
        calculator.performOperation("=")
        XCTAssert(calculator.result == secondNumber)
    }
}
