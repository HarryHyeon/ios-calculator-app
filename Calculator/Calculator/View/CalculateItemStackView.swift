//
//  CalculateItemStackView.swift
//  Calculator
//
//  Created by Rowan on 2023/02/02.
//

import UIKit

final class CalculateItemStackView: UIStackView {
    @IBOutlet private weak var calculateItemScrollView: UIScrollView!
    @IBOutlet private weak var operatorLabel: UILabel!
    @IBOutlet private weak var operandLabel: UILabel!
    
    private let numberFormatter = NumberFormatter(numberStyle: .decimal,
                                          roundingMode: .halfUp,
                                          usesSignificantDigits: true,
                                          maximumSignificantDigits: 20)
    
    private var currentOperand: String {
        return operandLabel.text ?? Sign.zero
    }
    private var currentOperator: String {
        return operatorLabel.text ?? Sign.empty
    }
    
    func removeAllSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func addCurrentItem() {
        guard let subview = generateCurrentItemStackView() else { return }
        
        add(subview, to: self)
        calculateItemScrollView.didAddSubview(subview)
    }
    
    private func generateCurrentItemStackView() -> UIStackView? {
        let operand = UILabel()
        operand.text = numberFormatter.convertToDecimal(from: currentOperand)
        operand.textColor = UIColor.white
        operand.font = UIFont.preferredFont(forTextStyle: .title3)
        
        let `operator` = UILabel()
        `operator`.text = currentOperator
        `operator`.textColor = UIColor.white
        `operator`.font = UIFont.preferredFont(forTextStyle: .title3)
        
        let result = UIStackView()
        result.addArrangedSubview(`operator`)
        result.addArrangedSubview(operand)
        result.axis = .horizontal
        result.spacing = 8
        result.alignment = .fill
        result.distribution = .fill
        
        InputHandler.shared.addInput(about: `operator`, and: operand)
        
        return result
    }
    
    private func add(_ subview: UIStackView, to superview: UIStackView) {
        superview.addArrangedSubview(subview)
    }
}