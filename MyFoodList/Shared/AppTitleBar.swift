//
//  HomeTitleUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/26.
//

import UIKit

class AppTitleBar: UIView {

    private let backButton = MyPackageButton()
    private let titleLabel = MyLabel()
    private let editButton = MyPackageButton()
    
    var setTitle: String? = nil {
        didSet {
            titleLabel.text = setTitle
        }
    }
    
    var setBackButtonImage: UIImage? = nil {
        didSet {
            backButton.buttonImage = setBackButtonImage
        }
    }
    
    var setEditButtonImage: UIImage? = nil {
        didSet {
            editButton.buttonImage = setEditButtonImage
        }
    }
    
    var backButtonAction: (() -> Void)? {
        didSet {
            backButton.buttonAction = backButtonAction
        }
    }
    
    var editButtonAction: (() -> Void)? {
        didSet {
            editButton.buttonAction = editButtonAction
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
        
        backButton.buttonText = ""
        backButton.buttonBackground = .clear
        backButton.viewPadding(to: width * 0.075, top: width * 0.06, bottom: width * 0.06, right: 0)
        
        titleLabel.font = .boldTitle2
        
        editButton.buttonText = ""
        editButton.buttonBackground = .clear
        editButton.viewPadding(to: width * 0.075, top: width * 0.06, bottom: width * 0.06, left: 0)
        
        let subScreen = MyStack(arrangedSubviews: [backButton, titleLabel, editButton])
        subScreen.axis = .horizontal
        subScreen.setBackgroundImage = .titleBackground
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            backButton.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.15),
            titleLabel.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.7),
            editButton.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.15)
        ])
    }
}
