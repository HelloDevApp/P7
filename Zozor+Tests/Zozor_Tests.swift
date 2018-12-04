//
//  Zozor_Tests.swift
//  CountOnMeTests
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class Zozor_Tests: XCTestCase {
    
    var calcul: Calcul!
    
    override func setUp() {
        super.setUp()
        calcul = Calcul()
    }
    // is used to calculate
    func easyCalcul(number1: Int, operator_: Operations, numer2: Int?) {
        
        calcul.addNewNumber(number1)
        calcul.appendOperatorAndNewStringForNextNumber(operator_: operator_)
        if numer2 != nil {
            calcul.addNewNumber(numer2!)
        }
        calcul.calculateTotal()
    }
    // addition test
    func testWhenAddsTenToTheResult_ThenResultEqualTen() {
        
        easyCalcul(number1: 0, operator_: .plus, numer2: 10)
        
        XCTAssert(calcul.total == 10)
    }
    // subtraction test
    func testWhenSubstractTenToResult_ThenResultEqualNegativeTen() {
        
        easyCalcul(number1: 0, operator_: .minus, numer2: 10)
        
        XCTAssert(calcul.total == -10)
    }
    // multiplication test
    func testWhenMultiplyTenByTen_ThenResultIsEqualOneHundred() {
        
        easyCalcul(number1: 10, operator_: .multiplication, numer2: 10)
        
        XCTAssert(calcul.total == 100)
    }
    // division test
    func testWhenDivideTenByTen_ThenResultIsEqualOne() {
        
        easyCalcul(number1: 10, operator_: .divide, numer2: 10)
        
        XCTAssert(calcul.total == 1)
    }
    // we check that the arrays are correctly updated
    func testGivenAddInArrays_WhenTappedOnClearButton_ThenArraysIsEmpty() {
        
        calcul.addNewNumber(10)
        calcul.appendOperatorAndNewStringForNextNumber(operator_: .divide)
        calcul.clear()

        XCTAssert(calcul.operators.count - 1 == 0 && calcul.stringNumbers.count - 1 == 0)
    }
    // we check that the expression of a calculation is not correct
    func testWhenExpressionIsNotCorrect_ThenIsExpressionCorrectEqualFalse() {
        
        easyCalcul(number1: 10, operator_: .multiplication, numer2: nil)
        
        XCTAssert(calcul.isExpressionCorrect == false)
    }
    // we check that the expression of a calculation is correct
    func testWhenExpressionIsCorrect_ThenIesExpressionCorrectEqualTrue() {
        
        calcul.addNewNumber(10)
        calcul.appendOperatorAndNewStringForNextNumber(operator_: .multiplication)
        calcul.addNewNumber(10)
        
        XCTAssert(calcul.isExpressionCorrect)
    }
    // we check that zero is displayed before the dot if the user presses the dot to start a calculation
    func testGivenStringNumberContainsNoDot_WhenTappedOnDotButton_ThenStringNumberContainsAZeroAndADot() {
        
        if let stringNumberLast = calcul.stringNumbers.last {
            XCTAssert(stringNumberLast.contains(".") == false)
        }
        
        calcul.addDot()
        
        if let stringNumberLast = calcul.stringNumbers.last {
            XCTAssert(stringNumberLast.contains("0."))
        }
    }
    // we check that only the dot is displayed
    func testWhenAddOnlyDot_ThenStringNumberContainsADot() {
        
        calcul.addNewNumber(5)
        
        calcul.addDot()
        
        XCTAssert(calcul.stringNumbers.last!.contains("."))
    }
    // we check that the calculations that return decimal results work
    func testWhenResultIsDouble_ThenResultIsDoubleEqualTrue() {
        
        easyCalcul(number1: 5, operator_: .divide, numer2: 2)
        
        XCTAssert(calcul.resultIsDouble)
    }
}
