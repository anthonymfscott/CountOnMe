//
//  ViewController.swift
//  CountOnMe
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Duplicated for modification by anthonymfscott on 15/04/2020.
//  Copyright © 2019 Vincent Saluzzo - © 2020 anthonymfscott. All rights reserved.
//

import UIKit

private enum Error {
    case lastElementIsSign, expressionIncomplete, expressionTooShort
}

class ViewController: UIViewController {
    // MARK: Outlets and properties
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var deleteButton: UIButton!
    
    var expression: Expression!

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = ""
        expression = Expression()
    }

    // MARK: Actions
    @IBAction private func numberButtonTapped(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }

        if expression.containsEqualsSign || textView.text.contains("Erreur") {
            reset()
        }

        add(numberText)
        deleteButton.setTitle("C", for: .normal)
    }

    @IBAction private func signButtonTapped(_ sender: UIButton) {
        guard let sign = sender.title(for: .normal) else { return }

        guard !expression.elements.isEmpty, !textView.text.contains("Erreur") else { return }

        // if there's a result from a previous calculation, show it as first element
        if expression.containsEqualsSign {
            textView.text = expression.elements.last
            expression.input = expression.elements.last!
        }

        // if a sign can be added, add it; otherwise show related error message
        if expression.isCoherent {
            add(" \(sign) ")
        } else {
            showErrorMessage(.lastElementIsSign)
        }
    }

    @IBAction private func equalsButtonTapped(_ sender: UIButton) {
        if expression.containsEqualsSign { return }

        guard expression.isCoherent else {
            showErrorMessage(.expressionIncomplete)
            return
        }

        guard expression.hasEnoughElements else {
            showErrorMessage(.expressionTooShort)
            return
        }

        add(" = \(expression.result)")
    }

    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        reset()
    }

    @IBAction func decimalButtonTapped(_ sender: UIButton) {
        guard expression.canAddPoint && !expression.containsEqualsSign else { return }

        add(".")
    }

    // MARK: Private methods
    private func add(_ element: String) {
        textView.text += element
        expression.input += element
    }

    private func reset() {
        textView.text = ""
        expression.input = ""
        
        deleteButton.setTitle("AC", for: .normal)
    }

    private func showErrorMessage(_ error: Error) {
        var title: String
        var message: String

        switch error {
        case .lastElementIsSign:
            title = "Erreur !"
            message = "Il y a déjà un opérateur !"
        case .expressionIncomplete:
            title = "Expression incomplète !"
            message = "Veuillez compléter votre calcul."
        case .expressionTooShort:
            title = "Expression trop courte !"
            message = "Veuillez continuer votre calcul."
        }

        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alertVC, animated: true)
    }
}
