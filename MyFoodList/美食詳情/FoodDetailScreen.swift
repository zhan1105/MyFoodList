//
//  FoodDetailScreen.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/6.
//

import UIKit

class FoodDetailScreen: MyViewController {

    private let titleBer = AppTitleBar()
    
    private let logoImage = MyPackageImage()
    private let foodLabel = MyLabel()
    
    private let foodDetail = FoodDetailUI()
    
    private let navigationButton = MyPackageButton()
    
    private let editItem: [String] = ["編輯", "刪除"]
    
    var food_id = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setEditAction() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for item in editItem {
            let action = UIAlertAction(title: item, style: .default) { [weak self] _ in
                guard let self = self else { return }
                if item == "編輯" {
                    pushViewController(EditDetailScreen())
                } else {
                    
                }
            }
            alert.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - UI
extension FoodDetailScreen {
    private func setupUI() {
        
        let width = UIScreen.main.bounds.width
        
        titleBer.setTitle = "美食詳情"
        titleBer.setBackButtonImage = .backCircle
        titleBer.backButtonAction = { [weak self] in self?.popViewController() }
        titleBer.setEditButtonImage = .editCircle
        titleBer.editButtonAction = { [weak self] in self?.setEditAction() }
        
        logoImage.setImage = .foodExample
        logoImage.setContentMode = .scaleToFill
        logoImage.setImageCornerRadius = 20
        logoImage.viewPadding(to: width * 0.05, bottom: 0)
        
        foodLabel.text = "美食名稱"
        foodLabel.font = UIFont.boldLargeTitle
        
        navigationButton.buttonText = "Google Maps"
        navigationButton.textFont = .boldTitle2
        navigationButton.buttonCornerRadius = 20
        navigationButton.viewPadding(to: width * 0.05, top: 0, bottom: width * 0.065)
        
        let spacer = MySpacer()
        
        let appScreen = MyStack(arrangedSubviews: [titleBer, logoImage, foodLabel, foodDetail, spacer, navigationButton])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBer.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            logoImage.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.325),
            foodLabel.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            foodDetail.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.275),
            spacer.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            navigationButton.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1)
        ])
    }
}
