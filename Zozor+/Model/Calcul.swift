//
//  Calcul.swift
//  CountOnMe
//
//  Created by Mac Book Pro on 21/11/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation

enum Operations: String {
    case plus = "+"
    case minus = "-"
}

class Calcul {
    
    //MARK: - Properties
    private var _total = 0
    private var _stringNumbers: [String] = [String()]
    private var _operators: [String] = ["+"]
    
    private var _isExpressionCorrect: Bool {
        if let stringNumber = _stringNumbers.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        return true
    }
    private var _canAddOperator: Bool {
        if let stringNumber = _stringNumbers.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        return true
    }
    
    var total: Int {
        return _total
    }
    var stringNumbers: [String] {
        return _stringNumbers
    }
    var operators: [String] {
        return _operators
    }

    var isExpressionCorrect: Bool {
        return _isExpressionCorrect
    }
    
    var canAddOperator: Bool {
        return _canAddOperator
    }
    
    
    //MARK: - Methods
    
    func appendOperatorAndNewStringForNextNumber(operator_: Operations) {
        _operators.append("\(operator_.rawValue)")
        _stringNumbers.append("")
    }

    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            _stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }
    
    func calculateTotal() {
        _total = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[i] == Operations.plus.rawValue {
                    _total += number
                } else if operators[i] == Operations.minus.rawValue {
                    _total -= number
                }
            }
        }
        clear()
    }
    
    func clear() {
        _stringNumbers = [String()]
        _operators = [Operations.plus.rawValue]
    }
    
    
}
