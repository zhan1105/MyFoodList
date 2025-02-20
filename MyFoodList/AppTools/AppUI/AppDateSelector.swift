//
//  AppDatePicker.swift
//  transfer
//
//  Created by 紹郁 on 2024/10/8.
//

import UIKit

class AppDateSelector: UIView {
    
    private(set) var newTextField = MyTextField()
    private let errorLabel = MyLabel()
    private let errorView = MyView()
    private let dateImage = MyImage()
    private let appPicker = MyStack()
    
    var fieldText: String? {
        get {
            newTextField.text
        }
        set {
            newTextField.text = newValue
        }
    }
    
    var setPlaceholder: String = "YYYY-MM-DD" {
        didSet {
            newTextField.placeholder = setPlaceholder
        }
    }
    
    var isSelect: Bool = false {
        didSet {
            dateImage.image = isSelect ? .selectCalendar : .unselectCalendar
            newTextField.layer.borderColor = isSelect ? UIColor.oceanBlue.cgColor : UIColor.skyGray.cgColor
            errorLabel.isHidden = true
        }
    }
    
    var errorText: String? = nil {
        didSet {
            errorLabel.text = errorText
        }
    }
    
    var shouldShowError: Bool = false {
        didSet {
            newTextField.layer.borderColor = shouldShowError ? UIColor.coralRed.cgColor : UIColor.skyGray.cgColor
            errorLabel.isHidden = !shouldShowError
        }
    }
    
    var onTapAction: (() -> Void)?
    
    init(){
        super.init(frame: .zero)
        setupUI()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: AppDatePicker) has not been implemented")
    }
    
    private func setupUI(){
        
        newTextField.font = UIFont.callout
        newTextField.placeholder = "YYYY-MM-DD"
        newTextField.backgroundColor = .pureWhite
        newTextField.layer.borderColor = UIColor.skyGray.cgColor
        newTextField.layer.borderWidth = 2
        newTextField.layer.cornerRadius = 10
        newTextField.textAlignment = .left
        newTextField.isUserInteractionEnabled = false
        newTextField.rightView = dateImage
        newTextField.rightViewMode = .always
        newTextField.padding(left: 25)
        
        dateImage.image = .unselectCalendar
        
        errorLabel.text = errorText
        errorLabel.textColor = .coralRed
        errorLabel.font = .subheadline
        errorLabel.textAlignment = .right
        errorLabel.isHidden = !shouldShowError
        errorLabel.backgroundColor = .clear
        
        errorView.addSubview(errorLabel)
        errorLabel.paddingAnchor(equalTo: errorView)
        
        appPicker.addArrangedSubviews([newTextField, errorView])
        appPicker.backgroundColor = .clear
        appPicker.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(appPicker)
        
        NSLayoutConstraint.activate([
            appPicker.topAnchor.constraint(equalTo: topAnchor),
            appPicker.bottomAnchor.constraint(equalTo: bottomAnchor),
            appPicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            appPicker.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            newTextField.heightAnchor.constraint(equalTo: appPicker.heightAnchor, multiplier: 0.7),
            newTextField.widthAnchor.constraint(equalTo: appPicker.widthAnchor),
            
            errorView.heightAnchor.constraint(equalTo: appPicker.heightAnchor, multiplier: 0.3),
            errorView.leadingAnchor.constraint(equalTo: appPicker.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: appPicker.trailingAnchor),
        ])
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap() {
        isSelect = true
        onTapAction?()
    }
}
