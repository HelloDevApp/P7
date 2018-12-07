//
//  Calcul.swift
//  CountOnMe
//
//  Created by Mac Book Pro on 21/11/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation

// contains the different operations
enum Operations: String {
    case plus = "+"
    case minus = "-"
    case multiplication = "x"
    case divide = "÷"
}

// this class contains all the logic to do a calculation
class Calcul {
    
    //MARK: - Properties
    // is equal to true if the result of a calculation is decimal or false if it is integer
    var resultIsDouble: Bool = false
    // final result
    private var _total = 0.0
    // array containing the numbers
    private var _stringNumbers: [String] = [String()]
    // containing the operators
    private var _operators: [String] = ["+"]
    // contains the value 0 to be displayed when the app is launched
    private let _basicResult = 0
    
    // checks that the expression is correct
    private var _isExpressionCorrect: Bool {
        if let stringNumber = _stringNumbers.last {
            if stringNumber.isEmpty || stringNumber.last == "." {
                return false
            }
        }
        return true
    }
    // returns the value of the property _total
    var total: Double {
        return _total
    }
    // returns the value of the property _stringNumbers
    var stringNumbers: [String] {
        return _stringNumbers
    }
    // returns the value of the property _operators
    var operators: [String] {
        return _operators
    }
    // returns the value of the property _basicResult
    var basicResult: Int {
        return _basicResult
    }
    // returns the value of the property _isExpressionCorrect
    var isExpressionCorrect: Bool {
        return _isExpressionCorrect
    }
    
    //MARK: - Methods
    // adds a number at the end of the array
    func addNewNumber(_ newNumber: Int) {
        if var stringNumber = stringNumbers.last {
            stringNumber += "\(newNumber)"
            _stringNumbers[stringNumbers.count-1] = stringNumber
        }
    }
    
    // adds an operator and prepares the place for the next number
    func appendOperatorAndNewStringForNextNumber(operator_: Operations) {
        _operators.append("\(operator_.rawValue)")
        _stringNumbers.append("")
    }
    
    // returns the result of the operation
    func calculateTotal() {
        _total = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            
            if let number = Double(stringNumber) {
                // i = operator[i]
                calculateByOperator(number: number, i: i)
            }
        }
        determineIfResultIsInteger()
        clear()
    }
    
    // i = index
    func calculateByOperator(number: Double, i: Int) {
        //plus
        if operators[i] == Operations.plus.rawValue {
            _total += number
        //minus
        } else if operators[i] == Operations.minus.rawValue {
            _total -= number
        //multiply
        } else if operators[i] == Operations.multiplication.rawValue {
            _total *= number
        //divide
        } else if operators[i] == Operations.divide.rawValue {
            _total /= number
        }
    }
    
    // allows you to convert the total and compare it to itself to know if it is an integer or a decimal
    func determineIfResultIsInteger() {
        let isInteger = floor(total) == total
        if isInteger {
            resultIsDouble = false
        } else {
            resultIsDouble = true
        }
    }
    
    // clear the arrays
    func clear() {
        _stringNumbers = [String()]
        _operators = [Operations.plus.rawValue]
    }
    
    // allows you to add a dot to the calculation
    func addDot() {
        if _stringNumbers[stringNumbers.count-1].isEmpty {
            _stringNumbers[stringNumbers.count-1] += "\(basicResult)."
        } else {
            _stringNumbers[stringNumbers.count-1] += "."
        }
    }
}
