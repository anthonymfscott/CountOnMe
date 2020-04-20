//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var expression: Expression!
  
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expression = Expression()
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if textView.text.firstIndex(of: "=") != nil {
            textView.text = ""
            expression.reset()
        }
        
        textView.text.append(numberText)
        
        if expression.elements.count > 0 && Int(expression.elements[expression.elements.count - 1]) != nil {
            expression.elements[expression.elements.count - 1] += numberText
        } else {
            expression.elements.append(numberText)
        }
    }
    
//    func tappedOperatorButton(_ sender: UIButton) {
//        guard let numberText = sender.title(for: .normal) else {
//           return
//        }
//
//        if expression.canAddOperator {
//            let operator = sender.title(for: .normal)
//            addOperator(operator)
//        } else {
//            showErrorMessage(.operator)
//        }
//    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if expression.canAddOperator {
            textView.text.append(" + ")
            expression.elements.append("+")
        } else {
            let alertVC = UIAlertController(title: "Erreur !", message: "Un opérateur est déjà mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if expression.canAddOperator {
            textView.text.append(" - ")
            expression.elements.append("-")
        } else {
            let alertVC = UIAlertController(title: "Erreur !", message: "Un opérateur est déjà mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if expression.canAddOperator {
            textView.text.append(" x ")
            expression.elements.append("x")
        } else {
            let alertVC = UIAlertController(title: "Erreur !", message: "Un opérateur est déjà mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if expression.canAddOperator {
            textView.text.append(" / ")
            expression.elements.append("/")
        } else {
            let alertVC = UIAlertController(title: "Erreur !", message: "Un opérateur est déjà mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expression.isCorrect else {
            let alertVC = UIAlertController(title: "Expression incomplète !", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard expression.hasEnoughElements else {
            textView.text = ""
            expression.reset()
            let alertVC = UIAlertController(title: "Expression trop courte !", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        textView.text.append(" = \(expression.result)")
    }
}
