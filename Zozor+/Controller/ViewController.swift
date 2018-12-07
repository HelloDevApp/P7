//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    // instance of the Calcul class
    private let _calcul = Calcul()
    // MARK: - Outlets
    // the label that displays the result
    @IBOutlet weak var textView: UITextView!
    // containing all the number buttons
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Action
    // contains the action of adding a number to the array
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                _calcul.addNewNumber(i)
                updateDisplay()
            }
        }
    }
    // contains the action that allows you to add a plus
    @IBAction func plus() {
        addOperatorAndUpdateDisplays(operator_: .plus)
    }
    // contains the action that allows you to add a minus
    @IBAction func minus() {
        addOperatorAndUpdateDisplays(operator_: .minus)
    }
    // contains the action that allows you to add a multiply
    @IBAction func multiplication() {
        addOperatorAndUpdateDisplays(operator_: .multiplication)
    }
    // contains the action that allows you to add a divide
    @IBAction func divide() {
        addOperatorAndUpdateDisplays(operator_: .divide)
    }
    // contains the action that allows to run a calcul
    @IBAction func equal() {
        guard _calcul.isExpressionCorrect else {
            //presentAlert
            presentAlertIsNotCorrect()
            return
        }
        
        _calcul.calculateTotal()
        //display the result of the calculation in double or in int
        convertTotalInTextView()
    }
    // delete text on screen and clear array
    @IBAction func clear() {
        _calcul.clear()
        textView.text = "\(_calcul.basicResult)"
    }
    // addDot
    @IBAction func dot(_ sender: Any) {
        if _calcul.stringNumbers.last != nil {
            guard (_calcul.stringNumbers.last!.contains(".")) else {
                _calcul.addDot()
                updateDisplay()
                return
            }
            return
        }
    }
    
    // MARK: - Methods
    // allows you to present an alert message if expression calcul is not correct
    private func presentAlertIsNotCorrect() {
        if _calcul.stringNumbers.count == 1 {
            presentAlert(title: "Zéro", message: "Démarrez un nouveau calcul !")
        } else {
            presentAlert(title: "Zéro", message: "Entrez une expression correcte !")
        }
    }
    // adds an operator to the array and updates the display
    private func addOperatorAndUpdateDisplays(operator_: Operations) {
        guard _calcul.isExpressionCorrect else {
            presentAlert(title: "Zéro", message: "Expression incorrecte !")
            return
        }
        _calcul.appendOperatorAndNewStringForNextNumber(operator_: operator_)
        updateDisplay()
    }
    
    // converts the displayed text to decimal or integer
    func convertTotalInTextView() {
        if _calcul.resultIsDouble {
            // Double
            textView.text += " = \(_calcul.total)"
        } else {
            // Integer
            textView.text += " = \(Int(_calcul.total))"
        }
        _calcul.resultIsDouble = false
    }
    // updates the display of the text on the screen
    private func updateDisplay() {
        // contains the text to be displayed on the screen
        var text = ""
        for (i, stringNumber) in _calcul.stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += _calcul.operators[i]
            }
            // Add number
            text += stringNumber
        }
        textView.text = text
    }
    // allows you to present an alert message
    private func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
