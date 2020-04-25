//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by anthonymfscott on 15/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Expression {
    var string = ""
    
    var elements: [String] {
        return string.split(separator: " ").map { "\($0)" }
    }
    
    private static let possibleSigns = ["+", "-", "x", "÷"]
    
    // Error check computed variables
    var isCoherent: Bool {
        for sign in Expression.possibleSigns where elements.last == sign {
            return false
        }
        return true
    }
    
    var hasEnoughElements: Bool {
        return elements.count >= 3
    }
    
    // déplacer dans Contrôleur ? (logique d'interface)
    var containsEqualsSign: Bool {
        return string.firstIndex(of: "=") != nil
    }
    
    var result: String {
        var operationsToReduce = elements
        
        while operationsToReduce.count > 1 {
            let left = Float(operationsToReduce[0])!
            let sign = operationsToReduce[1]
            let right = Float(operationsToReduce[2])!
            
            let result: Float
            switch sign {
                case "+":
                    result = left + right
                case "-":
                    result = left - right
                case "x":
                    result = left * right
                case "÷":
                    guard right != 0 else {
                        return "Erreur"
                    }
                    result = left / right
                default:
                    return "Opérateur inconnu !"
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        let finalResult = simplify(operationsToReduce.first!)
        
        return finalResult
    }
    
    private func simplify(_ floatNumber: String) -> String {
        let resultParts = floatNumber.split(separator: ".")
        for i in resultParts[1] where i != "0" {
            return floatNumber
        }
        return String(resultParts[0])
    }
}
