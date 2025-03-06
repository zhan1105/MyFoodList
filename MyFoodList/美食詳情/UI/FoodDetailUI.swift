//
//  FoodDetailUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/6.
//

import UIKit

class FoodDetailUI: UIView {

    private let priceLabel = MyLabel()
    private let phoneLabel = MyLabel()
    private let addressLabel = MyLabel()
    private let evaluateImage = EvaluateImageUI()
    
    var food_Price: String? {
        get {
            priceLabel.text
        }
        set {
            priceLabel.text = newValue
        }
    }
    
    var food_Phone: String? {
        get {
            phoneLabel.text
        }
        set {
            phoneLabel.text = newValue
        }
    }
    
    var food_Address: String? {
        get {
            addressLabel.text
        }
        set {
            addressLabel.text = newValue
        }
    }
    
    var setEvaluate: Int {
        get {
            evaluateImage.setEvaluate
        }
        set {
            evaluateImage.setEvaluate = newValue
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: FoodDetailUI) has not been implemented")
    }
    
    private func setupUI(){
        
        let width = UIScreen.main.bounds.width
        
        let labels: [MyLabel] = [priceLabel, phoneLabel, addressLabel]
        labels.forEach {
            $0.font = UIFont.boldTitle3
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.padding(to: width * 0.05, top: 0, bottom: width * 0.01)
        }
     
        priceLabel.text = "價位："
        phoneLabel.text = "電話："
        addressLabel.text = "地址："
        
        evaluateImage.viewPadding(to: width * 0.005)
        
        let topSpacer = MySpacer()
        let bottomSpacer = MySpacer(.coralRed)
        
        let subScreen = MyStack(arrangedSubviews: [topSpacer, priceLabel, phoneLabel, addressLabel, evaluateImage, bottomSpacer])
        subScreen.alignment = .center
        subScreen.layer.cornerRadius = 10
        subScreen.backgroundColor = .lightGrayWhite
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * 0.05),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -width * 0.05),
                        
            topSpacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.075),
            priceLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.2),
            phoneLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.2),
            addressLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.2),
            
            evaluateImage.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.95),
            evaluateImage.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.25),
            
            bottomSpacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.075)
        ])
        
        labels.forEach {
            $0.widthAnchor.constraint(equalTo: subScreen.widthAnchor).isActive = true
        }
    }
}
