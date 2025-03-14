//
//  SearchAlert.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/5.
//

import UIKit

class SearchAlert: MyViewController {
    
    weak var searchDelegate: SearchDelegate?
    
    private let titleBar = AppTitleBar()
    private let search = SearchUI()
    private let spacerButton = MyButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setMyBackgroundColor(.charcoalBlack.withAlphaComponent(0.6))
        setupUI()
    }
}

//MARK: - UI
extension SearchAlert {
    func setupUI() {
                
        titleBar.setTitle = "搜尋"
        titleBar.backgroundColor = .pureWhite
        titleBar.setEditButtonImage = .menuCircle
        titleBar.editButtonAction = { [weak self] in self?.dismissOverlay() }
        
        search.searchButtonAction = { [weak self] in
            guard let self = self else { return }
            
            let price = Int(search.pricrFieldText ?? "0")
            let food = search.searchFieldText
            
            self.searchDelegate?.search(food: food, price: price)
            self.dismissOverlay()
        }
        
        spacerButton.backgroundColor = .clear
        spacerButton.buttonAction = { [weak self] in self?.dismissOverlay() }
        
        let appScreen = MyStack(arrangedSubviews: [titleBar, search, spacerButton])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            search.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.4),
            spacerButton.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.5)
        ])
    }
}
