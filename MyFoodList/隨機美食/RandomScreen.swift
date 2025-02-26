//
//  RandomScreen.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/24.
//

import UIKit

class RandomScreen: MyViewController {

    private var contentView: RandomUI!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

//MARK: - UI
extension RandomScreen {
    private func setupUI() {
        
        let width = UIScreen.main.bounds.width
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        
        contentView = RandomUI(width: width, height: safeAreaHeight)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.infoButtonAction = { [weak self] in
            guard let self = self else { return }

        }
        
        contentView.chooseButtonAction = { [weak self] in
            guard let self = self else { return }
            self.contentView.setShowInfo(isShow: true, food: "美食名稱")
        }
        
        self.view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
