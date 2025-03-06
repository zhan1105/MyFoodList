//
//  SearchTitleBar.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/4.
//

import UIKit

class SearchTitleBar: UIView {
    
    private(set) var newTextField = MyTextField()
    private let iconImage = MyImage()
    private let textFieldView = MyView()
    private let moreButton = MyPackageButton()

    var setDelegate: UITextFieldDelegate? = nil {
        didSet {
            newTextField.delegate = setDelegate
        }
    }
    
    var fieldText: String? {
        get {
            return newTextField.text
        }
        set {
            newTextField.text = newValue
        }
    }
    
    var setMoreButtonAction: (() -> Void)? {
        didSet {
            moreButton.buttonAction = setMoreButtonAction
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: SearchTitleBar) has not been implemented")
    }
    
    private func setupUI(){
        
        let width = UIScreen.main.bounds.width
        
        iconImage.image = UIImage(systemSymbol: .search)
        iconImage.tintColor = .mediumGray
        
        newTextField.placeholder = "搜尋美食"
        newTextField.font = UIFont.boldBody
        newTextField.backgroundColor = .pureWhite
        newTextField.layer.cornerRadius = 25
        newTextField.textAlignment = .left
        newTextField.leftView = iconImage
        newTextField.leftViewMode = .always
        newTextField.padding(left: 25)
        
        textFieldView.addSubview(newTextField)
        NSLayoutConstraint.activate([
            newTextField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: width * 0.025),
            newTextField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -width * 0.025),
            newTextField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: width * 0.05),
            newTextField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor),
        ])
        
        moreButton.buttonText = ""
        moreButton.buttonImage = .menuCircle
        moreButton.viewPadding(to: width * 0.0375)
        
        let subScreen = MyStack(arrangedSubviews: [textFieldView, moreButton])
        subScreen.axis = .horizontal
        subScreen.setBackgroundImage = .titleBackground
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textFieldView.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.85),
            moreButton.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.15)
        ])
    }
}
