//
//  RandomScreen.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class RandomScreen: MyViewController {

    private var contentView: RandomUI!

    private let db = Firestore.firestore()
    
    private var foodList_ID = [String]()
    private var select_id = String()

    private var foodName =      String()
    private var price =         String()
    private var address =       String()
    private var link =          String()
    private var evaluate =      Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        Task { await FoodListID_FireStore() }
    }
    
    private func random_FoodID() {
        guard !foodList_ID.isEmpty else { return } // 確保列表不為空

        let random_ID = foodList_ID.randomElement()
        
        if let random_ID = random_ID, random_ID != select_id {
            Task { await self.FoodDetail_FireStore(id: random_ID) }
        } else {
            self.random_FoodID()
        }
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

            if let url = URL(string: link) {
                UIApplication.shared.open(url)
            }
        }
        
        contentView.chooseButtonAction = { [weak self] in
            guard let self = self else { return }
            
            self.random_FoodID()
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

//MARK: - FireStore
extension RandomScreen {
    private func FoodListID_FireStore() async {
        
        showLoading()
        
        let memberID = UserDefaults.standard.string(forKey: UserDefaultsKey.user_id.rawValue) ?? ""
        
        do {
            foodList_ID.removeAll()

            let data = db.collection(FireStoreKey.Member.rawValue).document(memberID)
            let dataResponse = try await data.getDocument()
            
            foodList_ID = dataResponse["FoodList_ID"] as! [String]
            
        } catch {
            MyPrint("Firestore 獲取清單ID失敗: \(error.localizedDescription)")
        }
        
        dismissLoading()
    }
    
    private func FoodDetail_FireStore(id: String) async {
                
        do {
            let data = db.collection(FireStoreKey.FoodList.rawValue).document(id)
            let dataResponse = try await data.getDocument()
            
            foodName = dataResponse["Food"] as! String
            price = dataResponse["Price"] as! String
            address = dataResponse["Address"] as! String
            link = dataResponse["Link"] as! String
            evaluate = dataResponse["Evaluate"] as! Int
            
            self.contentView.setShowInfo(isShow: true, food: foodName)
            contentView.setPrice = "價格：" + price
            contentView.setAddress = address
            contentView.setEvaluate = evaluate
            
        } catch {
            MyPrint("Firestore 獲取詳細資料失敗: \(error.localizedDescription)")
        }
    }
}
