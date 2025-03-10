//
//  SearchUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/5.
//

import UIKit

class SearchUI: UIView {
    
    private(set) var searchField = MyTextField()
    private let iconImage = MyImage()
    
    private(set) var minTextField = MyTextField()
    private(set) var maxTextField = MyTextField()
    private let midLabel = MyLabel()
    private let priceStack = MyStack()
    
    private let addressSelector = AppSelector()
    private let searchButton = MyPackageButton()
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: SearchUI) has not been implemented")
    }
    
    private func setupUI(){
        
        let width = UIScreen.main.bounds.width
        
        iconImage.image = UIImage(systemSymbol: .search)
        iconImage.tintColor = .mediumGray
        
        searchField.placeholder = "搜尋美食"
        searchField.font = UIFont.boldBody
        searchField.backgroundColor = .pureWhite
        searchField.layer.cornerRadius = 20
        searchField.textAlignment = .left
        searchField.leftView = iconImage
        searchField.leftViewMode = .always
        searchField.padding(left: 25)
        
        midLabel.text = "～"
        midLabel.font = .boldTitle3
        
        minTextField.placeholder = "最低價格"
        maxTextField.placeholder = "最高價格"
        
        let priceField: [MyTextField] = [minTextField, maxTextField]
        priceField.forEach {
            $0.font = .boldBody
            $0.layer.cornerRadius = 20
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
        
        addressSelector.fieldPlaceholder = "地址"
        addressSelector.fieldFont = .boldBody
        addressSelector.select_BorderColor = UIColor.clear.cgColor
        addressSelector.setBorderColor = UIColor.clear.cgColor
        addressSelector.setCornerRadius = 20
        
        let topSpacer = MySpacer()
        let bottomSpacer = MySpacer()
        
        searchButton.buttonText = "搜尋"
        searchButton.textFont = .boldTitle3
        searchButton.buttonCornerRadius = 20
        searchButton.viewPadding(bottom: width * 0.05)
        
        let subScreen = MyStack(arrangedSubviews: [topSpacer, searchField, priceStack, addressSelector, bottomSpacer, searchButton])
        subScreen.alignment = .center
        subScreen.spacing = width * 0.025
        subScreen.backgroundColor = .lightGrayWhite
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            topSpacer.widthAnchor.constraint(equalToConstant: width * 0.9),
            topSpacer.heightAnchor.constraint(equalToConstant: width * 0.05),
            
            searchField.widthAnchor.constraint(equalToConstant: width * 0.9),
            searchField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.15),
            
            priceStack.widthAnchor.constraint(equalToConstant: width * 0.9),
            priceStack.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.15),
            
            addressSelector.widthAnchor.constraint(equalToConstant: width * 0.9),
            addressSelector.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.225),
            
            bottomSpacer.widthAnchor.constraint(equalToConstant: width * 0.9),
            bottomSpacer.heightAnchor.constraint(equalToConstant: width * 0.05),
            
            searchButton.widthAnchor.constraint(equalToConstant: width * 0.9),
            searchButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.225),
        ])
    }
}
