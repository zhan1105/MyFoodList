//
//  FoodListCell.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/26.
//

import UIKit

class FoodListCell: UITableViewCell {
    
    private let pictureImage = MyPackageImage()
    
    private let titleLabel = MyLabel()
    private let evaluateImage = EvaluateImageUI()
    private let titleStack = MyStack()
    
    private let priceIconLabel = MyIconLabel()
    private let addressIconLabel = MyIconLabel()

    var setPicture: UIImage? = nil {
        didSet {
            pictureImage.setImage = setPicture
        }
    }
    
    var setTitle: String? = nil {
        didSet {
            titleLabel.text = setTitle
        }
    }
    
    var setPrice: String? = nil {
        didSet {
            priceIconLabel.setLabel = setPrice
        }
    }
    
    var setAddress: String? = nil {
        didSet {
            addressIconLabel.setLabel = setAddress
        }
    }
    
    var setEvaluate: Int = 0 {
        didSet {
            evaluateImage.setEvaluate = setEvaluate
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = .clear
        self.selectedBackgroundView = selectedView
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: NotificationCell) has not been implemented")
    }
    
    private func setupUI() {
        
        let width = UIScreen.main.bounds.width
        
        pictureImage.setImage = .foodExample
        pictureImage.setContentMode = .scaleAspectFill
        pictureImage.setImageCornerRadius = 10
        pictureImage.viewPadding(to: 10)
        
        titleLabel.font = .boldTitle3
        titleLabel.textAlignment = .left
        
        evaluateImage.viewPadding(to: width * 0.00375)
        
        titleStack.addArrangedSubviews([titleLabel, evaluateImage])
        titleStack.axis = .horizontal
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: titleStack.widthAnchor, multiplier: 0.7),
            evaluateImage.widthAnchor.constraint(equalTo: titleStack.widthAnchor, multiplier: 0.3)
        ])
        
        priceIconLabel.setIcon = .dollar
        addressIconLabel.setIcon = .mark
        
        let spacer = MySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [pictureImage, titleStack, priceIconLabel, addressIconLabel, spacer])
        subScreen.layer.cornerRadius = 10
        subScreen.layer.borderWidth = 2
        subScreen.alignment = .center
        subScreen.layer.borderColor = UIColor.mediumGray.cgColor
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor, constant: width * 0.025),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -width * 0.025),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * 0.05),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -width * 0.05),
            
            pictureImage.widthAnchor.constraint(equalToConstant: width),
            pictureImage.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.65),
            
            titleStack.widthAnchor.constraint(equalToConstant: width * 0.825),
            titleStack.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.125),
            
            priceIconLabel.widthAnchor.constraint(equalToConstant: width * 0.85),
            priceIconLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            
            addressIconLabel.widthAnchor.constraint(equalToConstant: width * 0.85),
            addressIconLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            
            spacer.widthAnchor.constraint(equalToConstant: width),
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.025)
        ])
    }
}
