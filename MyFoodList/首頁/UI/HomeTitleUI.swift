//
//  HomeTitleUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/26.
//

import UIKit

class HomeTitleUI: UIView {

    private let logoImage = MyPackageImage()
    private let titleLabel = MyLabel()
    
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
        logoImage.viewPadding(to: width * 0.01)
        
        titleLabel.text = "XX的美食清單"
        titleLabel.font = .boldTitle2
        titleLabel.textAlignment = .left
        
        let subScreen = MyStack(arrangedSubviews: [logoImage, titleLabel])
        subScreen.axis = .horizontal
        subScreen.setBackgroundImage = .titleBackground
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            logoImage.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.25),
            titleLabel.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.75)
        ])
    }
}
