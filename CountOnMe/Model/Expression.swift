//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by anthonymfscott on 15/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Expression {
    var elements = [String]()
    
    // Error check computed variables
    var isCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var hasEnoughElements: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var result: String {
        while elements.count > 1 {
            let left = Int(elements[0])!
            let operand = elements[1]
            let right = Int(elements[2])!
            
            let result: Int
            switch operand {
                case "+": result = left + right
                case "-": result = left - right
                case "x": result = left * right
                case "/": result = left / right
                default: fatalError("Opérateur inconnu!")
            }
            
            elements = Array(elements.dropFirst(3))
            elements.insert("\(result)", at: 0)
        }
        
        return elements.first!
    }
    
    func reset() {
        elements.removeAll()
    }
}
