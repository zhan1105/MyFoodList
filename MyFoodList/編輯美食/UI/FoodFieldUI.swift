//
//  FoodFieldUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/3.
//

import UIKit

class FoodFieldUI: UIView {
    
    private let titleLabel = UILabel()
    private(set) var newTextField = MyTextField()

    var setTitle: String? = nil {
        didSet {
            titleLabel.text = setTitle
        }
    }
    
    var setDelegate: UITextFieldDelegate? = nil {
        didSet {
            newTextField.delegate = setDelegate
        }
    }
    
    var setKeyboardType: UIKeyboardType = .default {
        didSet {
            newTextField.keyboardType = setKeyboardType
        }
    }
    
    var fieldText: String? {
        get {
            newTextField.text
        }
        set {
            newTextField.text = newValue
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: FoodFieldUI) has not been implemented")
    }
    
    private func setupUI(){
        
        titleLabel.font = .boldBody
        titleLabel.textAlignment = .left
        
        newTextField.placeholder = ""
        newTextField.font = .boldBody
        newTextField.textAlignment = .left
        
        let spacer = MySpacer()
     
        let subScreen = MyStack(arrangedSubviews: [titleLabel, newTextField, spacer])
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.4),
            newTextField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.5),
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1)
        ])
    }

}
