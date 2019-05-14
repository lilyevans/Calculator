import XCTest
@testable import Calculator

class ViewModelTests: XCTestCase {
    var mockCalculator : CalculatorMock!
    var testDisplayToUpdate : String!
    var updateTestDisplay : ((String) -> Void)!
    var viewModel : ViewModel!
    
    override func setUp() {
        mockCalculator = CalculatorMock()
        testDisplayToUpdate = ""
        updateTestDisplay = { self.testDisplayToUpdate = $0 }
        
        viewModel = ViewModel(updateTotalDisplayFunc: updateTestDisplay, calculator: mockCalculator)
    }

    func testClearAllResetsTotal() {
        viewModel.clearAll()
        
        XCTAssert(viewModel.totalForDisplay == "0")
    }
    
    func testEntersDigitsAndUpdatesDisplay() {
        viewModel.enterCharacter("2")
        
        XCTAssert(testDisplayToUpdate == "2")
    }
    
    func testEntersDecimalAndUpdatesDisplay() {
        viewModel.enterCharacter("2")
        viewModel.enterCharacter(".")
        viewModel.enterCharacter("2")
        
        XCTAssert(testDisplayToUpdate == "2.2")
    }
    
    func testDecimalGetsLeadingZeroWhenUserNotAlreadyEnteringANumber() {
        viewModel.enterOperation("=")
        viewModel.enterCharacter(".")
        
        XCTAssert(testDisplayToUpdate == "0.")
    }
    
    func testAppliesFormattingWhenUpdatingDisplay() {
        viewModel.enterCharacter("1")
        viewModel.enterCharacter("2")
        viewModel.enterCharacter("3")
        viewModel.enterCharacter("4")
        
        XCTAssert(testDisplayToUpdate == "1,234")
    }
    
    func testDoesNotAllowEnteringMoreThanNineDigits() {
        viewModel.enterCharacter("1")
        viewModel.enterCharacter("1")
        viewModel.enterCharacter("1")
        viewModel.enterCharacter("1")
        viewModel.enterCharacter("1")
        viewModel.enterCharacter("1")
        viewModel.enterCharacter("1")
        viewModel.enterCharacter("1")
        viewModel.enterCharacter("1")
        
        viewModel.enterCharacter("9")
        
        XCTAssert(testDisplayToUpdate == "111,111,111", testDisplayToUpdate)
    }
    
    func testDeleteResetsToZeroWhenDisplayingSingleDigit() {
        viewModel.enterCharacter("2")
        viewModel.delete()
        
        XCTAssert(testDisplayToUpdate == "0")
    }
    
    func testReformatsDisplayAfterDelete() {
        viewModel.enterCharacter("1")
        viewModel.enterCharacter("2")
        viewModel.enterCharacter("3")
        viewModel.enterCharacter("4")
        
        viewModel.delete()
        
        XCTAssert(testDisplayToUpdate == "123")
    }
    
    func testDoesNotDeleteWhenUserNotTypingANumber() {
        viewModel.enterOperation("=")
        viewModel.delete()
        
        XCTAssert(testDisplayToUpdate == "23")
    }
    
    func testDisplaysTotalInScientificNotationWhenTooLong() {
        mockCalculator.numberToReturn = 0.000000001
        viewModel.enterOperation("=")
        
        XCTAssert(testDisplayToUpdate == "1e-9")
    }
    
    func testDisplaysErrorOnNonRealResult() {
        mockCalculator.numberToReturn = 2 / 0
        
        viewModel.enterOperation("=")
        
        XCTAssert(testDisplayToUpdate == "Error")
    }
    
    func testSubsequentOperationEntryDoesNotSetOperand() {
        viewModel.enterCharacter("3")
        viewModel.enterOperation("+")
        viewModel.enterOperation("-")
        
        print(mockCalculator.setOperandCalledWith)
        XCTAssert(mockCalculator.setOperandCalledWith.count == 1)
    }
}
