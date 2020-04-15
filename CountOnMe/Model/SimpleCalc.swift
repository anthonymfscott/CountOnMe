//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by anthonymfscott on 15/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class SimpleCalc {
    var operationsToReduce: [String]
    
    init(operationsToReduce: [String]) {
        self.operationsToReduce = operationsToReduce
    }
    
    var result: String {
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
                case "+": result = left + right
                case "-": result = left - right
                case "x": result = left * right
                case "/": result = left / right
                default: fatalError("Opérateur inconnu!")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        return operationsToReduce.first!
    }
}
