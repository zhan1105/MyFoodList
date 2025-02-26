//
//  RandomUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/25.
//

import UIKit

class RandomUI: UIView {

    private let logoImage = MyPackageImage()
    private let foodLabel = MyLabel()
    private let infoButton = MyPackageButton()
    
    private let priceLabel = MyLabel()
    private let addressTitleLabel = MyLabel()
    private let addressLabel = MyLabel()
    private let infoStack = MyStack()
    
    private let infoImage = MyPackageButton()
    private let infoView = MyStack()

    private let randomButton = RandomButtonUI()
    
    private var setFood: String? = nil {
        didSet {
            foodLabel.text = setFood
        }
    }
    
    private var setPrice: String? = nil {
        didSet {
            priceLabel.text = setPrice
        }
    }
    
    private var setAddress: String? = nil {
        didSet {
            addressLabel.text = setAddress
        }
    }
    
    var chooseButtonAction: (() -> Void)? {
        didSet {
            randomButton.chooseButtonAction = chooseButtonAction
        }
    }
    
    var infoButtonAction: (() -> Void)? {
        didSet {
            infoImage.buttonAction = infoButtonAction
        }
    }
    
    func setShowInfo(isShow: Bool, food: String = "今天吃什麼？") {
        if isShow {
            infoView.isHidden = false
        }

        UIView.animate(withDuration: 0.3, animations: {
            self.infoView.alpha = isShow ? 1 : 0
            
        }) { _ in
            if !isShow {
                self.infoView.isHidden = true
            }
        }
        
        UIView.transition(with: randomButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.setFood = food
        }, completion: nil)
    }
    
    init(width: CGFloat, height: CGFloat){
        super.init(frame: .zero)
        setupUI(width: width, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: RandomUI) has not been implemented")
    }
    
    private func setupUI(width: CGFloat, height: CGFloat){
        
        logoImage.setImage = .searchFood
        logoImage.viewPadding(to: width * 0.025, top: width * 0.075, bottom: width * 0.075)
        
        foodLabel.text = "今天吃什麼？"
        foodLabel.font = UIFont.boldLargeTitle
        foodLabel.padding(bottom: width * 0.05)

        priceLabel.text = "價位：$0 ~ 1000"
        priceLabel.font = UIFont.boldHeadline
        priceLabel.textAlignment = .left
        priceLabel.numberOfLines = 0
        priceLabel.padding(to: width * 0.05, top: width * 0.05, bottom: 0)

        addressTitleLabel.text = "地址："
        addressTitleLabel.font = UIFont.boldHeadline
        addressTitleLabel.textAlignment = .left
        addressTitleLabel.numberOfLines = 0
        addressTitleLabel.padding(to: width * 0.05, top: 0, bottom: 0)
        
        addressLabel.text = "台中市太平區樹孝路168-5號"
        addressLabel.font = UIFont.boldHeadline
        addressLabel.textAlignment = .left
        addressLabel.numberOfLines = 0
        addressLabel.padding(to: width * 0.05, top: 0, bottom: width * 0.05)
        
        infoStack.addArrangedSubviews([priceLabel, addressTitleLabel, addressLabel])
        infoStack.distribution = .fillEqually
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        
        infoImage.buttonText = ""
        infoImage.buttonBackground = .clear
        infoImage.buttonBackgroundImage = .goto
        infoImage.viewPadding(to: width * 0.1, left: 0, right: width * 0.025)
        
        infoView.addArrangedSubviews([infoStack, infoImage])
        infoView.axis = .horizontal
        infoView.backgroundColor = .lightGrayWhite
        infoView.layer.cornerRadius = 10
        infoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoStack.widthAnchor.constraint(equalTo: infoView.widthAnchor, multiplier: 0.85),
            infoImage.widthAnchor.constraint(equalTo: infoView.widthAnchor, multiplier: 0.15)
        ])
        
        setShowInfo(isShow: false)
        
        let spacer = MySpacer()
        
        randomButton.resetButtonAction = { [weak self] in
            guard let self = self else { return }
            setShowInfo(isShow: false)
        }
        
        let subScreen = MyStack(arrangedSubviews: [logoImage, foodLabel, infoView, spacer, randomButton])
        subScreen.alignment = .center
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            logoImage.widthAnchor.constraint(equalToConstant: width),
            logoImage.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.365),
            
            foodLabel.widthAnchor.constraint(equalToConstant: width),
            foodLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),

            infoView.widthAnchor.constraint(equalToConstant: width * 0.85),
            infoView.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.175),

            spacer.widthAnchor.constraint(equalToConstant: width),
            spacer.heightAnchor.constraint(lessThanOrEqualTo: subScreen.heightAnchor, multiplier: 0.4),

            randomButton.widthAnchor.constraint(equalToConstant: width),
            randomButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.235)
        ])
    }
}
