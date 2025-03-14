//
//  SearchUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/5.
//

import UIKit

class SearchUI: UIView {
    
    private(set) var searchField = MyTextField()
    private let logoImage = MyImage()
    
    private(set) var priceField = MyTextField()
    
    private let searchButton = MyPackageButton()
    
    var searchFieldText: String? {
        get {
            searchField.text
        }
        set {
            searchField.text = newValue
        }
    }
    
    var pricrFieldText: String? {
        get {
            priceField.text
        }
        set {
            priceField.text = newValue
        }
    }
    
    var searchButtonAction: (() -> Void)? {
        didSet {
            searchButton.buttonAction = searchButtonAction
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: SearchUI) has not been implemented")
    }
    
    private func setupUI(){
        
        let width = UIScreen.main.bounds.width
        
        logoImage.image = UIImage(systemSymbol: .search)
        logoImage.tintColor = .mediumGray
        
        searchField.placeholder = "搜尋美食"
        searchField.font = UIFont.boldBody
        searchField.backgroundColor = .pureWhite
        searchField.layer.cornerRadius = 20
        searchField.textAlignment = .left
        searchField.leftView = logoImage
        searchField.leftViewMode = .always
        searchField.padding(left: 25)
        
        priceField.placeholder = "價位"
        priceField.font = UIFont.boldBody
        priceField.backgroundColor = .pureWhite
        priceField.layer.cornerRadius = 20
        priceField.textAlignment = .left
        priceField.keyboardType = .numberPad
        priceField.padding(left: 25)
        
        let topSpacer = MySpacer()
        let bottomSpacer = MySpacer()
        
        searchButton.buttonText = "搜尋"
        searchButton.textFont = .boldTitle3
        searchButton.buttonCornerRadius = 20
        searchButton.viewPadding(bottom: width * 0.05)
        
        let subScreen = MyStack(arrangedSubviews: [topSpacer, searchField, priceField, bottomSpacer, searchButton])
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
            topSpacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier:0.075),
            
            searchField.widthAnchor.constraint(equalToConstant: width * 0.9),
            searchField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.2),
            
            priceField.widthAnchor.constraint(equalToConstant: width * 0.9),
            priceField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.2),
            
            bottomSpacer.widthAnchor.constraint(equalToConstant: width * 0.9),
            bottomSpacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier:0.225),
            
            searchButton.widthAnchor.constraint(equalToConstant: width * 0.9),
            searchButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.3),
        ])
    }
}
