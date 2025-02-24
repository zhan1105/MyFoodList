//
//  MyTabBarScreen.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/24.
//

import UIKit

class MyTabBarScreen: MyViewController {

    private let screenView = UIView()
    private let appTabBar = AppTabBar()
    
    private let homeScreen = HomeScreen()
    private let locationScreen = LocationScreen()
    private let searchScreen = SearchScreen()
    private let randomScreen = RandomScreen()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setMyBackgroundColor(bottomColor: .lightSkyWhite)
        setupUI()
    }
    
    private func setScreen(_ screen: UIViewController, _ selectTab: TabBarType){

        self.appTabBar.selectTab = selectTab
        self.screenView.subviews.forEach { $0.removeFromSuperview() }

        addChild(screen)
        self.screenView.addSubview(screen.view) // 將子視圖添加到 screenView 中
        screen.view.frame = self.screenView.bounds // 設置子視圖的框架
        screen.view.autoresizingMask = [.flexibleWidth, .flexibleHeight] // 允許自動調整大小
        screen.didMove(toParent: self)
    }
}

//MARK: - UI
extension MyTabBarScreen {
    private func setupUI() {
        
        setScreen(homeScreen, .FoodList)

        appTabBar.setTapAction(.FoodList) { [weak self] in
            guard let self = self else { return }
            setScreen(homeScreen, .FoodList)
        }
        
        appTabBar.setTapAction(.Location) { [weak self] in
            guard let self = self else { return }
            setScreen(locationScreen, .Location)
        }
        
        appTabBar.setTapAction(.AddFood) { [weak self] in
            guard let self = self else { return }
            self.pushViewController(AddFoodScreen())
        }
        
        appTabBar.setTapAction(.Search) { [weak self] in
            guard let self = self else { return }
            setScreen(searchScreen, .Search)
        }
        
        appTabBar.setTapAction(.WhatToEat) { [weak self] in
            guard let self = self else { return }
            setScreen(randomScreen, .WhatToEat)
        }
        
        let appScreen = MyStack(arrangedSubviews: [screenView, appTabBar])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            screenView.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
            appTabBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
        ])
    }
}
