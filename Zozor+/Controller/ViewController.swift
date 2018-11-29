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
    private let _calcul = Calcul()
    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Action

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                _calcul.addNewNumber(i)
                updateDisplay()
            }
        }
    }

    @IBAction func plus() {
        addOperatorAndUpdateDisplays(operator_: .plus)
    }

    @IBAction func minus() {
        addOperatorAndUpdateDisplays(operator_: .minus)
    }
    
    @IBAction func multiplication() {
        addOperatorAndUpdateDisplays(operator_: .multiplication)
    }
    
    @IBAction func divide() {
        addOperatorAndUpdateDisplays(operator_: .divide)
    }
    
    @IBAction func equal() {
        guard _calcul.isExpressionCorrect else {
            //presentAlert
            presentAlertIsNotCorrect()
            return
        }
        
        _calcul.calculateTotal()
        //allows to display the result of the calculation in double or in int
        convertTotalInTextView()
    }
    
    @IBAction func clear() {
        _calcul.clear()
        textView.text = "\(_calcul.basicResult)"
    }

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
    
    private func presentAlertIsNotCorrect() {
        if _calcul.stringNumbers.count == 1 {
            presentAlert(title: "Zéro", message: "Démarrez un nouveau calcul !")
        } else {
            presentAlert(title: "Zéro", message: "Entrez une expression correcte !")
        }
    }
    
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
            textView.text += " = \(_calcul.total)"
        } else {
            textView.text += " = \(Int(_calcul.total))"
        }
        _calcul.resultIsDouble = false
    }
    
    private func updateDisplay() {
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
    
    private func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
