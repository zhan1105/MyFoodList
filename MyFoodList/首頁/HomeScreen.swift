//
//  HomeScreen.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/13.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class HomeScreen: MyViewController {
    
    private let titleBar = HomeTitleUI()
    private let foodListTable = UITableView()
    
    private let db = Firestore.firestore()
    
    private var foodListItem = [FoodListItem]()
    private var foodList_ID = [String]()
    
    private var memberName = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        foodListTable.delegate = self
        foodListTable.dataSource = self
        
        setupUI()
        
        Task { await FoodListFireStore() }
    }
}

//MARK: - UI
extension HomeScreen {
    private func setupUI() {

        titleBar.setSearchButtonAction = { [weak self] in
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
extension HomeScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foodListItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodListCell", for: indexPath) as? FoodListCell else {
            return UITableViewCell()
        }
        let index = indexPath.row
        let data = foodListItem[index]
        
        cell.setTitle = data.food
        cell.setPrice = data.price
        cell.setAddress = data.address
        cell.setEvaluate = data.evaluate
        cell.setPicture = UIImage.convertStrToImage(data.picture01)
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let index = indexPath.row
        let data = foodListItem[index]
        
        let foodDetailScreen = FoodDetailScreen()
        foodDetailScreen.food_id = data.id
        
        pushViewController(foodDetailScreen)
    
        tableView.reloadData()
    }
}

//MARK: - SearchDelegate
extension HomeScreen: SearchDelegate {
    func search(food: String?, price: Int?) {
        Task { await searchFoodList_FireStore(food: food, price: price) }
    }
}

//MARK: - FireStore
extension HomeScreen {
    private func FoodListFireStore() async {
        
        showLoading()
        
        let memberID = UserDefaults.standard.string(forKey: UserDefaultsKey.user_id.rawValue) ?? ""
        
        do {
            foodList_ID.removeAll()
            foodListItem.removeAll()
            
            let data = db.collection(FireStoreKey.Member.rawValue).document(memberID)
            let dataResponse = try await data.getDocument()
            
            memberName = dataResponse["Name"] as! String
            titleBar.setTitle = memberName + " 的美食清單"
            
            foodList_ID = dataResponse["FoodList_ID"] as! [String]
            
            for food_id in foodList_ID {
                let data_foodList = db.collection(FireStoreKey.FoodList.rawValue).document(food_id)
                let dataResponse_foodList = try await data_foodList.getDocument()
                
                foodListItem.append(FoodListItem(id:            food_id,
                                                 food:          dataResponse_foodList["Food"] as! String,
                                                 price:         dataResponse_foodList["Price"] as! String,
                                                 address:       dataResponse_foodList["Address"] as! String,
                                                 coordinate:    dataResponse_foodList["Coordinate"] as! String,
                                                 link:          dataResponse_foodList["Link"] as! String,
                                                 evaluate:      dataResponse_foodList["Evaluate"] as! Int,
                                                 picture01:     dataResponse_foodList["Picture01"] as! String,
                                                 picture02:     dataResponse_foodList["Picture01"] as! String))
            }
            
            foodListTable.reloadData()
            
        } catch {
            MyPrint("Firestore 獲取清單失敗: \(error.localizedDescription)")
        }
        
        dismissLoading()
    }
    
    private func searchFoodList_FireStore(food: String?, price: Int?) async {
        
        showLoading()
        
        do {
           
            guard price != nil || food != nil else {
                dismissLoading()
                return
            }
                        
            foodListItem.removeAll()
                        
            var isFoundData: Bool = true
            
            for food_id in foodList_ID {
                
                let data = db.collection(FireStoreKey.FoodList.rawValue).document(food_id)
                let dataResponse = try await data.getDocument()
                
                let maxPriceData =      dataResponse["Price_Max"] as! Int

                let foodData =          dataResponse["Food"] as! String
                let priceData =         dataResponse["Price"] as! String
                let addressData =       dataResponse["Address"] as! String
                let coordinateData =    dataResponse["Coordinate"] as! String
                let linkData =          dataResponse["Link"] as! String
                let evaluateData =      dataResponse["Evaluate"] as! Int
                let picture01Data =     dataResponse["Picture01"] as! String
                let picture02Data =     dataResponse["Picture01"] as! String
                
                let matchesPrice = price != nil && maxPriceData <= price!
                let matchesFood = food != nil && foodData.contains(food!)
                
                if matchesPrice || matchesFood {
                    foodListItem.append(FoodListItem(
                        id:             food_id,
                        food:           foodData,
                        price:          priceData,
                        address:        addressData,
                        coordinate:     coordinateData,
                        link:           linkData,
                        evaluate:       evaluateData,
                        picture01:      picture01Data,
                        picture02:      picture02Data
                    ))
                }
                
                isFoundData = matchesPrice || matchesFood
            }
            
            if !isFoundData {
                showMessage("沒有符合的美食")

                Task { await FoodListFireStore() }
            }
            
            foodListTable.reloadData()
            
            
        } catch {
            MyPrint("Firestore 搜尋失敗: \(error.localizedDescription)")
        }
        
        dismissLoading()
    }
}
