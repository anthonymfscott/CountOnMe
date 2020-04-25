//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class ExpressionTests: XCTestCase {
    var expression: Expression!
    
    override func setUp() {
        super.setUp()
        expression = Expression()
    }
    
    func testAddition() {
        expression.string = "2 + 3"
        
        XCTAssertEqual(expression.result, "5")
    }
    
    func testSubstraction() {
        expression.string = "2 - 3"
        
        XCTAssertEqual(expression.result, "-1")
    }
    
    func testMultiplication() {
        expression.string = "2 x 3"
        
        XCTAssertEqual(expression.result, "6")
    }
    
    func testDivision() {
        expression.string = "6 ÷ 3"
        
        XCTAssertEqual(expression.result, "2")
    }
    
    func testDivisionToFloat() {
        expression.string = "3 ÷ 2"
        
        XCTAssertEqual(expression.result, "1.5")
    }
    
    func testDivisionByZero() {
        expression.string = "3 ÷ 0"
        
        XCTAssertEqual(expression.result, "Erreur")
    }
    
    func testMultipleOperations() {
        expression.string = "1 + 2 - 3"
        
        XCTAssertEqual(expression.result, "0")
    }
    
    func testMultipleOperationsIncludingDivisionByZero() {
        expression.string = "1 + 2 ÷ 0 - 3"
        
        XCTAssertEqual(expression.result, "Erreur")
    }
    
    func testExpressionIsCoherent() {
        expression.string = "1 + 2"
        
        XCTAssertTrue(expression.isCoherent)
    }
    
    func testExpressionIsNotCoherent() {
        expression.string = "1 + "
        
        XCTAssertFalse(expression.isCoherent)
    }
    
    func testExpressionDoesNotHaveEnoughElements() {
        expression.string = "1"
        
        XCTAssertFalse(expression.hasEnoughElements)
    }
    
    func testExpressionContainsEqualsSign() {
        expression.string = "5 x 9 = 45"
        
        XCTAssertTrue(expression.containsEqualsSign)
    }
    
    func testSignIsWrong() {
        expression.string = "1 / 3"

        XCTAssertEqual(expression.result, "Opérateur inconnu !")
    }
    
    func testSimplifyToInt() {
        expression.string = "1.0 + 2.0"
        
        XCTAssertEqual(expression.result, "3")
    }
}
