//
//  CoordinateFieldUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/6.
//

import UIKit

class CoordinateFieldUI: UIView {

    private let titleLabel = MyLabel()
    private let midLabel = MyLabel()
    
    private(set) var latTextField = MyTextField()
    private(set) var lngTextField = MyTextField()
    
    private let priceStack = MyStack()
    
    var setDelegate: UITextFieldDelegate? = nil {
        didSet {
            latTextField.delegate = setDelegate
            lngTextField.delegate = setDelegate
        }
    }
    
    var latFieldText: String? {
        get {
            latTextField.text
        }
        set {
            latTextField.text = newValue
        }
    }
    
    var lngFieldText: String? {
        get {
            lngTextField.text
        }
        set {
            lngTextField.text = newValue
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
        
        titleLabel.text = "經緯度："
        titleLabel.font = .boldBody
        titleLabel.textAlignment = .left
        
        midLabel.text = ","
        midLabel.font = .boldTitle3
        
        let priceField: [MyTextField] = [lngTextField, latTextField]
        priceField.forEach {
            $0.placeholder = ""
            $0.font = .boldBody
            $0.keyboardType = .decimalPad
        }
        
        priceStack.addArrangedSubviews([latTextField, midLabel, lngTextField])
        priceStack.axis = .horizontal
        priceStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            latTextField.widthAnchor.constraint(equalTo: priceStack.widthAnchor, multiplier: 0.4),
            midLabel.widthAnchor.constraint(equalTo: priceStack.widthAnchor, multiplier: 0.2),
            lngTextField.widthAnchor.constraint(equalTo: priceStack.widthAnchor, multiplier: 0.4),
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
