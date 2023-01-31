//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    enum Condition {
        static let zero = "0"
        static let zeroTwice = "00"
        static let empty = ""
        static let minus = "-"
    }
    
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var operandLabel: UILabel!
    @IBOutlet weak var currentOperatorLabel: UILabel!
    @IBOutlet weak var currentOperandLabel: UILabel!
    
    @IBOutlet weak var calculateItemStackView: UIStackView!
    @IBOutlet weak var currentCalculateItem: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCurrentCalculateItem()
        initializeScrollView()
    }
    
    private func initializeCurrentCalculateItem() {
        self.operandLabel.text = Condition.zero
        self.operatorLabel.text = Condition.empty
    }
    
    private func initializeScrollView() {
        calculateItemStackView
            .arrangedSubviews
            .forEach { $0.removeFromSuperview() }
    }
    
    @IBAction func makeOperand(_ sender: UIButton) {
        guard let inputNumber = sender.currentTitle else { return }
        
        if let operand = operandLabel.text,
           operand != Condition.zero {
            operandLabel.text = operand + inputNumber
        } else if let operand = operandLabel.text,
                  operand == Condition.zero,
                  inputNumber != Condition.zero,
                  inputNumber != Condition.zeroTwice {
            operandLabel.text = inputNumber
        }
    }
    
    @IBAction func clearOperandLabel(_ sender: UIButton) {
        operandLabel.text = Condition.zero
    }
    
    @IBAction func toggleSign(_ sender: UIButton) {
        guard let operandText = operandLabel.text,
              operandText != Condition.zero,
              let currentOperand = Double(operandText) else { return }
        
        operandLabel.text = String(-currentOperand)
    }
    
    @IBAction func touchOperatorButton(_ sender: UIButton) {
        guard let inputOperator = sender.currentTitle else { return }
        
        if operandLabel.text == Condition.zero {
            operatorLabel.text = inputOperator
        } else {
            guard let subview = generateCurrentItemStackView() else { return }
            
            add(subview, to: calculateItemStackView)
            initializeCurrentCalculateItem()
            currentOperatorLabel.text = sender.currentTitle
        }
    }
    
    func add(_ subview: UIStackView, to superview: UIStackView) {
        let calculateItem = subview
        
        superview.addArrangedSubview(calculateItem)
    }
    
    func generateCurrentItemStackView() -> UIStackView? {
        let operand = UILabel()
        operand.text = currentOperandLabel.text
        operand.textColor = UIColor.white
        operand.font = UIFont.preferredFont(forTextStyle: .title3)
        
        let `operator` = UILabel()
        `operator`.text = currentOperatorLabel.text
        `operator`.textColor = UIColor.white
        `operator`.font = UIFont.preferredFont(forTextStyle: .title3)
        
        let result = UIStackView()
        result.addArrangedSubview(`operator`)
        result.addArrangedSubview(operand)
        result.axis = .horizontal
        result.spacing = 8
        result.alignment = .fill
        result.distribution = .fill
        
        return result
    }
    
    @IBAction func calculateCurrentFormula(_ sender: UIButton) {
        
    }

}
