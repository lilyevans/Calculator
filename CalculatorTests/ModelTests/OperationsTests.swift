import XCTest
@testable import Calculator

class OperationsTests: XCTestCase {
    let operations = Operations()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testContainsChangeSignOperator() {
        guard let associatedOp = operations.all["+/-"] else {
            XCTFail()
            return
        }
        
        let result : Double
        let operand = 2.0
        
        switch associatedOp {
        case .unaryOperation(let function):
            result = function(operand)
        default:
            result = 0
            XCTFail()
        }
        
        let expectedResult = operand * -1
        XCTAssert(result == expectedResult)
    }
    
    func testContainsPercentOperator() {
        guard let associatedOp = operations.all["%"] else {
            XCTFail()
            return
        }
        
        let result : Double
        let operand = 2.0
        
        switch associatedOp {
        case .unaryOperation(let function):
            result = function(operand)
        default:
            result = 0
            XCTFail()
        }
        
        let expectedResult = operand / 100
        XCTAssert(result == expectedResult)
    }
    
    func testContainsAdditionOperator() {
        guard let associatedOp = operations.all["+"] else {
            XCTFail()
            return
        }
        
        let result : Double
        let operand1 = 2.0
        let operand2 = 1.0
        
        switch associatedOp {
        case .binaryOperation(let function):
            result = function(operand1, operand2)
        default:
            result = 0
            XCTFail()
        }
        
        let expectedResult = operand1 + operand2
        XCTAssert(result == expectedResult)
    }
    
    func testContainsSubtractionOperator() {
        guard let associatedOp = operations.all["-"] else {
            XCTFail()
            return
        }
        
        let result : Double
        let operand1 = 2.0
        let operand2 = 1.0
        
        switch associatedOp {
        case .binaryOperation(let function):
            result = function(operand1, operand2)
        default:
            result = 0
            XCTFail()
        }
        
        let expectedResult = operand1 - operand2
        XCTAssert(result == expectedResult)
    }
    
    func testContainsMultiplicationOperator() {
        guard let associatedOp = operations.all["×"] else {
            XCTFail()
            return
        }
        
        let result : Double
        let operand1 = 6.0
        let operand2 = 3.0
        
        switch associatedOp {
        case .binaryOperation(let function):
            result = function(operand1, operand2)
        default:
            result = 0
            XCTFail()
        }
        
        let expectedResult = operand1 * operand2
        XCTAssert(result == expectedResult)
    }
    
    func testDividesTwoNumbers() {
        guard let associatedOp = operations.all["÷"] else {
            XCTFail()
            return
        }
        
        let result : Double
        let operand1 = 6.0
        let operand2 = 3.0
        
        switch associatedOp {
        case .binaryOperation(let function):
            result = function(operand1, operand2)
        default:
            result = 0
            XCTFail()
        }
        
        let expectedResult = operand1 / operand2
        XCTAssert(result == expectedResult)
    }
}
