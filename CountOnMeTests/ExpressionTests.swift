//
//  ExpressionTests.swift
//  ExpressionTests
//
//  Created by anthonymfscott on 15/04/2020.
//  Copyright © 2019 Vincent Saluzzo - © 2020 anthonymfscott. All rights reserved.
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
        expression.input = "2 + 3"

        XCTAssertEqual(expression.result, "5")
    }

    func testSubtraction() {
        expression.input = "2 - 3"

        XCTAssertEqual(expression.result, "-1")
    }

    func testMultiplication() {
        expression.input = "2 x 3"

        XCTAssertEqual(expression.result, "6")
    }

    func testDivision() {
        expression.input = "6 ÷ 3"

        XCTAssertEqual(expression.result, "2")
    }

    func testDivisionToFloat() {
        expression.input = "3 ÷ 2"

        XCTAssertEqual(expression.result, "1.5")
    }

    func testDivisionByZero() {
        expression.input = "3 ÷ 0"

        XCTAssertEqual(expression.result, "Erreur")
    }

    func testMultipleOperations() {
        expression.input = "1 + 2 - 3"

        XCTAssertEqual(expression.result, "0")
    }

    func testMultipleOperationsIncludingDivisionByZero() {
        expression.input = "1 + 2 ÷ 0 - 3"

        XCTAssertEqual(expression.result, "Erreur")
    }

    func testExpressionIsCoherent() {
        expression.input = "1 + 2"

        XCTAssertTrue(expression.isCoherent)

        expression.input = "1 + "

        XCTAssertFalse(expression.isCoherent)
    }

    func testExpressionDoesNotHaveEnoughElements() {
        expression.input = "1"

        XCTAssertFalse(expression.hasEnoughElements)
    }

    func testExpressionContainsEqualsSign() {
        expression.input = "5 x 9 = 45"

        XCTAssertTrue(expression.containsEqualsSign)
    }

    func testSignIsWrong() {
        expression.input = "1 / 3"

        XCTAssertEqual(expression.result, "Erreur d'opérateur")
    }

    func testOperationsPriority() {
        expression.input = "1 + 2 x 3 - 5 ÷ 2"

        XCTAssertEqual(expression.result, "4.5")
    }
    
    func testAddPoint() {
        expression.input = "1.2"
        
        XCTAssertFalse(expression.canAddPoint)
    }
}
