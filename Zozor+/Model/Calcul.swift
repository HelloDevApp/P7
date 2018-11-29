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

class Calcul {
    
    //MARK: - Properties
    var resultIsDouble: Bool = false
    private var _total = 0.0 // final result
    private var _stringNumbers: [String] = [String()] // array containing the numbers
    private var _operators: [String] = ["+"] // containing the operators
    private let _basicResult = 0 // contains the value 0 to be displayed when the app is launched
    
    // checks that the expression is correct
    private var _isExpressionCorrect: Bool {
        if let stringNumber = _stringNumbers.last {
            if stringNumber.isEmpty || stringNumber.last == "." {
                return false
            }
        }
        return true
    }
    
    var total: Double {
        return _total
    }
    var stringNumbers: [String] {
        return _stringNumbers
    }
    var operators: [String] {
        return _operators
    }
    var basicResult: Int {
        return _basicResult
    }
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
            determineIfOperatorIsDivisor() // if operators contains Divisor, resultIsDouble = true
            if let number = Double(stringNumber) {
                // i = operator[i]
                calculateByOperator(number: number, i: i)
            }
        }
        if _total.remainder(dividingBy: 2) == 0 || _total.remainder(dividingBy: 2) == 1 {
            resultIsDouble = false
        }
        clear()
    }
    // determine if the operator is a divisor
    func determineIfOperatorIsDivisor() {
        for operator_ in operators {
            if operator_ == Operations.divide.rawValue {
                resultIsDouble = true
            }
        }
    }
    // i = index
    func calculateByOperator(number: Double, i: Int) {
        print( _total.remainder(dividingBy: number))
        if operators[i] == Operations.plus.rawValue { //plus
            _total += number
        } else if operators[i] == Operations.minus.rawValue { //minus
            _total -= number
        } else if operators[i] == Operations.multiplication.rawValue { //multiply
            _total *= number
        } else if operators[i] == Operations.divide.rawValue { //divide
            //if (total / number) returns an integer we change the value of resultIsDouble
            if _total.truncatingRemainder(dividingBy: number) == 0 {
                resultIsDouble = false
            }
            _total /= number
        }
    }
    
    // clear the array
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
        resultIsDouble = true //????????
    }
}
