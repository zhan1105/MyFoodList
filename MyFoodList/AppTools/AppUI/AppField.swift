//
//  EditView.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/6.
//

import UIKit

class AppField: UIView {
    
    private(set) var newTextField = MyTextField()
    private let errorLabel = MyLabel()
    private let errorView = MyView()
    private let countLabel = MyLabel()
    private let iconImage = MyImage()
    private let appField = MyStack()
    
    var fieldText: String? {
        get {
            newTextField.text
        }
        set {
            newTextField.text = newValue
        }
    }
    
    var fieldFont: UIFont = .body {
        didSet {
            newTextField.font = fieldFont
        }
    }
    
    var fieldContentType: UITextContentType! {
        didSet {
            newTextField.textContentType = fieldContentType
        }
    }
    
    var fieldAlignment: NSTextAlignment = .left {
        didSet {
            newTextField.textAlignment = fieldAlignment
        }
    }
    
    var fieldRightViewMode: UITextField.ViewMode = .always {
        didSet {
            newTextField.rightViewMode = fieldRightViewMode
        }
    }
    
    var fieldLeftViewMode: UITextField.ViewMode = .always {
        didSet {
            newTextField.leftViewMode = fieldLeftViewMode
        }
    }
    
    var isSelect: Bool = false {
        didSet {
            borderColor = isSelect ? UIColor.oceanBlue.cgColor : UIColor.skyGray.cgColor
            newTextField.layer.borderColor = borderColor
            shouldShowError = false
        }
    }
    
    private var borderColor: CGColor? = UIColor.skyGray.cgColor
    
    var setFieldBorderColor: CGColor? = UIColor.skyGray.cgColor {
        didSet {
            borderColor = setFieldBorderColor
            newTextField.layer.borderColor = borderColor
        }
    }
    
    var setCornerRadius: CGFloat = 0 {
        didSet {
            newTextField.layer.cornerRadius = setCornerRadius
        }
    }
    
    var setBorderWidth: CGFloat = 0 {
        didSet {
            newTextField.layer.borderWidth = setBorderWidth
        }
    }
    
    var setIcon: UIImage? = .idCard {
        didSet {
            iconImage.image = setIcon
            newTextField.leftViewMode = .always
            newTextField.padding(left: 20)
        }
    }
    
    var showFieldIcon: Bool = false {
        didSet {
            newTextField.leftViewMode = showFieldIcon ? .always : .never
            newTextField.padding(left: 25)
        }
    }
    
    var textCount: Int = 0 {
        didSet {
            updateCountLabel()
        }
    }
    
    var textTotalCount: Int = 0 {
        didSet {
            updateCountLabel()
        }
    }
    
    var isTotleCount: Bool = false {
        didSet {
            countColor = isTotleCount ? .charcoalBlack : .mediumGray
            countLabel.textColor = countColor
        }
    }
    
    var countColor: UIColor? = .mediumGray
    
    var errorText: String? = nil {
        didSet {
            errorLabel.text = errorText
        }
    }
    
    var shouldShowError: Bool = false {
        didSet {
            newTextField.layer.borderColor = shouldShowError ? UIColor.coralRed.cgColor : borderColor
            countLabel.textColor = shouldShowError ? .coralRed : countColor
            errorLabel.isHidden = !shouldShowError
        }
    }
    
    var setKeyboardType: UIKeyboardType = .default {
        didSet {
            newTextField.keyboardType = setKeyboardType
        }
    }
    
    var setAutocapitalizationType: UITextAutocapitalizationType = .none {
        didSet {
            newTextField.autocapitalizationType = setAutocapitalizationType
        }
    }
    
    var setPlaceholder: String = "" {
        didSet {
            newTextField.placeholder = setPlaceholder
        }
    }
    
    func setDelegate(_ delegate: UITextFieldDelegate){
        newTextField.delegate = delegate
    }
    
    init(placeholder: String? = nil){
        super.init(frame: .zero)
        setupUI(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(placeholder: String?){
        
        iconImage.tintColor = .black
        iconImage.image = setIcon
        
        countLabel.font = .callout
        
        // 設定 TextField
        newTextField.placeholder = placeholder
        newTextField.font = UIFont.callout
        newTextField.backgroundColor = .pureWhite
        newTextField.layer.borderColor = UIColor.skyGray.cgColor
        newTextField.layer.borderWidth = 2
        newTextField.layer.cornerRadius = 10
        newTextField.textAlignment = .left
        newTextField.leftView = iconImage
        newTextField.leftViewMode = .never
        newTextField.rightView = countLabel
        newTextField.rightViewMode = .never
        newTextField.padding(left: 25)
        
        errorLabel.text = errorText
        errorLabel.textColor = .coralRed
        errorLabel.font = .subheadline
        errorLabel.textAlignment = .right
        errorLabel.isHidden = !shouldShowError
        errorLabel.backgroundColor = .clear
        
        errorView.addSubview(errorLabel)
        errorLabel.paddingAnchor(equalTo: errorView)
        
        appField.addArrangedSubviews([newTextField, errorView])
        appField.backgroundColor = .clear
        appField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(appField)
        
        NSLayoutConstraint.activate([
            appField.topAnchor.constraint(equalTo: topAnchor),
            appField.bottomAnchor.constraint(equalTo: bottomAnchor),
            appField.leadingAnchor.constraint(equalTo: leadingAnchor),
            appField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            newTextField.heightAnchor.constraint(equalTo: appField.heightAnchor, multiplier: 0.7),
            newTextField.widthAnchor.constraint(equalTo: appField.widthAnchor),
            
            errorView.heightAnchor.constraint(equalTo: appField.heightAnchor, multiplier: 0.3),
            errorView.widthAnchor.constraint(equalTo: appField.widthAnchor),
        ])
    }
    
    private func updateCountLabel() {
        countLabel.text = "\(textCount)/\(textTotalCount)"
        newTextField.rightViewMode = .always
        newTextField.padding(left: 15)
        self.isTotleCount = textCount == textTotalCount
    }
}
