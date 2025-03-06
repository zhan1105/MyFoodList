//
//  SearchScreen.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/24.
//

import UIKit

class SearchScreen: MyViewController {
    
    private let titleBar = SearchTitleBar()
    private let foodListTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodListTable.delegate = self
        foodListTable.dataSource = self
        
        setupUI()
    }
}

//MARK: - UI
extension SearchScreen {
    private func setupUI() {
        
        titleBar.setMoreButtonAction = { [weak self] in
            guard let self = self else { return }
            let searchAlert = SearchAlert()
            searchAlert.searchDelegate = self
            self.overlayAlert(searchAlert)
        }
        
        foodListTable.register(FoodListCell.self, forCellReuseIdentifier: "FoodListCell")
        foodListTable.separatorStyle = .none
        foodListTable.backgroundColor = .clear
        foodListTable.translatesAutoresizingMaskIntoConstraints = false

        let appScreen = MyStack(arrangedSubviews: [titleBar, foodListTable])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            foodListTable.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9)
        ])
    }
}

//MARK: - TableDelegate
extension SearchScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodListCell", for: indexPath) as? FoodListCell else {
            return UITableViewCell()
        }
        
        cell.setTitle = "美食名稱"
        cell.setPrice = "100 ~ 1000"
        cell.setAddress = "台中市北區進化路280號"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let index = indexPath.row
                
        
    
        tableView.reloadData()
    }
}

//MARK: - SearchDelegate
extension SearchScreen: SearchDelegate {
    func showSearchAlert() { }
    
    func search(text: String) {
        MyPrint("123")
    }
}

