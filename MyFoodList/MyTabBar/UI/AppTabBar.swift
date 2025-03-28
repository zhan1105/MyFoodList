//
//  AppTabBar.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/24.
//

import UIKit

class AppTabBar: UIView {
    
    private let foodListTabItem     = AppTabItem(.FoodList)
    private let locationTabItem     = AppTabItem(.Location)
    private let addFoodTabItem      = MyPackageButton()
    private let whatToEatTabItem    = AppTabItem(.WhatToEat)
    private let settingTabItem      = AppTabItem(.Setting)
    
    var selectTab: TabBarType = .FoodList {
        didSet {
            for item in TabBarType.allCases {
                switch item {
                case .FoodList:
                    foodListTabItem.setIcon = item == selectTab ? .foodListSelected : .foodListNotSelected
                case .Location:
                    locationTabItem.setIcon = item == selectTab ? .locationSelected : .locationNotSelected
                case .WhatToEat:
                    whatToEatTabItem.setIcon = item == selectTab ? .whatToEatSelected : .whatToEatNotSelected
                case .Setting:
                    settingTabItem.setIcon = item == selectTab ? .settingSelected : .settingNotSelected
                default:
                    break
                }
            }
        }
    }

    func setTapAction(_ type: TabBarType, _ onTapAction: (() -> Void)?){
        switch type {
        case .FoodList:
            foodListTabItem.onTapAction = onTapAction
        case .Location:
            locationTabItem.onTapAction = onTapAction
        case.AddFood:
            addFoodTabItem.buttonAction = onTapAction
        case .WhatToEat:
            whatToEatTabItem.onTapAction = onTapAction
        case .Setting:
            settingTabItem.onTapAction = onTapAction
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: AppTabBar) has not been implemented")
    }
    
    private func setupUI(){

        let width = UIScreen.main.bounds.width
        
        addFoodTabItem.buttonText = ""
        addFoodTabItem.buttonBackground = .clear
        addFoodTabItem.buttonImage = .addFood
        addFoodTabItem.viewPadding(to: width * 0.035)
        
        let subScreen = MyStack(arrangedSubviews: [foodListTabItem, locationTabItem, addFoodTabItem, whatToEatTabItem, settingTabItem])
        subScreen.axis = .horizontal
        subScreen.backgroundColor = .lightSkyWhite
        subScreen.distribution = .fillEqually
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
