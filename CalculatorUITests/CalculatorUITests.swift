import XCTest

class CalculatorUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testFunctionalityWiredToUI() {
        let app = XCUIApplication()
        
        app.buttons["3"].tap()
        XCTAssert(app.staticTexts.element.label == "3")
        
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        XCTAssert(app.staticTexts.element.label == "6")
        
        app.buttons["="].tap()
        XCTAssert(app.staticTexts.element.label == "9")
        
        app.buttons["9"].tap()
        app.staticTexts["9"].swipeRight()
        XCTAssert(app.staticTexts.element.label == "0")
    }
}
