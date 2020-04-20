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
        expression.elements = ["2", "+", "3"]
        
        XCTAssertEqual(expression.result, "5")
    }
    
    func testSubstraction() {
        expression.elements = ["2", "-", "3"]
        
        XCTAssertEqual(expression.result, "-1")
    }
    
    func testMultiplication() {
        expression.elements = ["2", "x", "3"]
        
        XCTAssertEqual(expression.result, "6")
    }
    
    func testGivenExpressionIsNotComplete_ThenExpressionIsNotCorrect() {
        expression.elements = ["1", "+"]
        
        XCTAssertEqual(expression.isCorrect, false)
    }
}
