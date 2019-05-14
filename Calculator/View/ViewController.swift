import UIKit

class ViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var buttonRows: UIStackView!
    @IBOutlet weak var totalDisplay: UILabel!
    
    var viewModel : ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeButtonsCircular()
        
        let updateDisplay = { self.totalDisplay.text = $0 }
        viewModel = ViewModel(updateTotalDisplayFunc: updateDisplay, calculator: CalculatorModel())
        
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
        viewModel?.clearAll()
    }
    
    @IBAction func characterTapped(_ sender: UIButton) {
        viewModel?.enterCharacter(sender.currentTitle!)
    }
    
    @IBAction func operationTapped(_ sender: UIButton) {
        viewModel?.enterOperation(sender.currentTitle!)
    }
    
    @IBAction func displaySwiped(_ sender: UISwipeGestureRecognizer) {
        viewModel?.delete()
    }
    
    private func makeButtonsCircular() {
        for case let buttonRow as UIStackView in buttonRows.subviews {
            for case let button as UIButton in buttonRow.subviews {
                button.layer.cornerRadius = 37
            }
            for case let internalButtonRow as UIStackView in buttonRow.subviews {
                for case let button as UIButton in internalButtonRow.subviews {
                    button.layer.cornerRadius = 37
                }
            }
        }
    }
}
