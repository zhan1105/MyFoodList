//
//  HomeTitleUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/27.
//

import UIKit

class HomeTitleUI: UIView {

    private let logoImage = MyPackageImage()
    private let titleLabel = MyLabel()
    private let searchButton = MyPackageButton()

    var setTitle: String? = nil {
        didSet {
            titleLabel.text = setTitle
        }
    }
    
    var setSearchButtonAction: (() -> Void)? {
        didSet {
            searchButton.buttonAction = setSearchButtonAction
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: HomeTitleUI) has not been implemented")
    }
    
    private func setupUI(){
        
        let width = UIScreen.main.bounds.width
        
        logoImage.setImage = .foodLogo
        logoImage.viewPadding(to: width * 0.025, right: 0)
        
        titleLabel.text = "XX的美食清單"
        titleLabel.font = .boldTitle2
        
        searchButton.buttonText = ""
        searchButton.buttonImage = UIImage(systemSymbol: .search)
        searchButton.buttonTintColor = .charcoalBlack
        searchButton.viewPadding(to: width * 0.025, left: 0)
        
        let subScreen = MyStack(arrangedSubviews: [logoImage, titleLabel, searchButton])
        subScreen.axis = .horizontal
        subScreen.setBackgroundImage = .titleBackground
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            logoImage.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.15),
            titleLabel.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.7),
            searchButton.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.15)
        ])
    }
}
