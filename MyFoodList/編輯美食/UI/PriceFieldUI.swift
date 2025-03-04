//
//  PriceFieldUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/3.
//

import UIKit

class PriceFieldUI: UIView {

    private let titleLabel = MyLabel()
    private let midLabel = MyLabel()

    private(set) var minTextField = MyTextField()
    private(set) var maxTextField = MyTextField()
    
    private let priceStack = MyStack()
    
    var setDelegate: UITextFieldDelegate? = nil {
        didSet {
            minTextField.delegate = setDelegate
            maxTextField.delegate = setDelegate
        }
    }
    
    var minFieldText: String? {
        get {
            minTextField.text
        }
        set {
            minTextField.text = newValue
        }
    }
    
    var maxFieldText: String? {
        get {
            maxTextField.text
        }
        set {
            maxTextField.text = newValue
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: PriceFieldUI) has not been implemented")
    }
    
    private func setupUI(){
        
        titleLabel.text = "價位："
        titleLabel.font = .boldBody
        titleLabel.textAlignment = .left
        
        midLabel.text = "～"
        midLabel.font = .boldTitle3
        
        let priceField: [MyTextField] = [minTextField, maxTextField]
        priceField.forEach {
            $0.placeholder = ""
            $0.font = .boldBody
            $0.keyboardType = .numberPad
        }
        
        priceStack.addArrangedSubviews([minTextField, midLabel, maxTextField])
        priceStack.axis = .horizontal
        priceStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            minTextField.widthAnchor.constraint(equalTo: priceStack.widthAnchor, multiplier: 0.4),
            midLabel.widthAnchor.constraint(equalTo: priceStack.widthAnchor, multiplier: 0.2),
            maxTextField.widthAnchor.constraint(equalTo: priceStack.widthAnchor, multiplier: 0.4),
        ])
        
        let spacer = MySpacer()

        let subScreen = MyStack(arrangedSubviews: [titleLabel, priceStack, spacer])
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.4),
            priceStack.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.5),
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1)
        ])
    }
}
