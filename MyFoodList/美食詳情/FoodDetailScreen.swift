//
//  FoodDetailScreen.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/6.
//

import UIKit
import FSPagerView
import FirebaseCore
import FirebaseFirestore

class FoodDetailScreen: MyViewController {

    private let titleBer = AppTitleBar()
    
    private let logoBanner = FoodDetailBannerUI()
    private let foodLabel = MyLabel()
    
    private let foodDetail = FoodDetailUI()
    
    private let navigationButton = MyPackageButton()
    
    private let db = Firestore.firestore()

    private let editItem: [String] = ["編輯", "刪除"]
    private var pictureData = [String]()
    private var link = String()
    
    var food_id = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logoBanner.setDelegate(self)
        
        setupUI()
        
        Task { await FoodDetail_FireStore() }
    }
    
    private func setEditAction() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for item in editItem {
            let action = UIAlertAction(title: item, style: .default) { [weak self] _ in
                guard let self = self else { return }
                if item == "編輯" {
                    let editDetailScreen = EditDetailScreen()
                    editDetailScreen.food_id = food_id
                    editDetailScreen.editDetailType = .Edit
                    
                    pushViewController(editDetailScreen)
                } else {
                    Task { await self.DeleteDetail_FireStore() }
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
        
        foodLabel.text = "美食名稱"
        foodLabel.font = UIFont.boldLargeTitle
        
        navigationButton.buttonText = "Google Maps"
        navigationButton.textFont = .boldTitle2
        navigationButton.buttonCornerRadius = 20
        navigationButton.viewPadding(to: width * 0.05, top: 0, bottom: width * 0.065)
        navigationButton.buttonAction = { [weak self] in
            guard let self = self else { return }
            
            if let url = URL(string: link) {
                UIApplication.shared.open(url)
            }
        }
        
        let spacer = MySpacer()
        
        let appScreen = MyStack(arrangedSubviews: [titleBer, logoBanner, foodLabel, foodDetail, spacer, navigationButton])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBer.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            logoBanner.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.325),
            foodLabel.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            foodDetail.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.275),
            spacer.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.0875),
            navigationButton.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1125)
        ])
    }
}

//MARK: - Banner設定相關
extension FoodDetailScreen: FSPagerViewDataSource,FSPagerViewDelegate{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return pictureData.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.imageView?.image = UIImage.convertStrToImage(pictureData[index])
        
        logoBanner.setBannerCurrentPage = index
        
        return cell
    }
}

//MARK: - FireStore
extension FoodDetailScreen {
    private func FoodDetail_FireStore() async {
        
        showLoading()
                
        do {
            let data = db.collection(FireStoreKey.FoodList.rawValue).document(food_id)
            let dataResponse = try await data.getDocument()
                         
            let picture01 = dataResponse["Picture01"] as! String
            let picture02 = dataResponse["Picture02"] as! String

            pictureData.append(picture01)
            pictureData.append(picture02)
                        
            logoBanner.setBannerTotalPage = pictureData.count
            logoBanner.setBannerIsInfinite = pictureData.count == 0 ? false : true
            logoBanner.reloadDataBanner()
            
            let food = dataResponse["Food"] as! String
            foodLabel.text = food
            
            let price = dataResponse["Price"] as! String
            let address = dataResponse["Address"] as! String
            let evaluate = dataResponse["Evaluate"] as! Int
            
            foodDetail.food_Price = "價位：" + price
            foodDetail.food_Address = address
            foodDetail.setEvaluate = evaluate
            
            link = dataResponse["Link"] as! String
            
        } catch {
            MyPrint("Firestore 獲取詳情失敗: \(error.localizedDescription)")
        }
        
        dismissLoading()
    }
    
    private func DeleteDetail_FireStore() async {
        
        showLoading()
        
        let memberID = UserDefaults.standard.string(forKey: UserDefaultsKey.user_id.rawValue) ?? ""

        do {
            try await db.collection(FireStoreKey.FoodList.rawValue).document(food_id).delete()
            
            let data = db.collection(FireStoreKey.Member.rawValue).document(memberID)
            let dataRpsponse = try await data.getDocument()
            
            var foodList: [String] = dataRpsponse["FoodList_ID"] as! [String]
            
            foodList.enumerated().forEach { index, foodID in
                if foodID == food_id {
                    foodList.remove(at: index)
                }
            }

            let updateData: [String: Any] = ["FoodList_ID": foodList]
            try await data.updateData(updateData)
            
            clearToViewController(MyTabBarScreen())
            
        } catch {
            MyPrint("Firestore 刪除詳情失敗: \(error.localizedDescription)")
        }
        
        dismissLoading()
    }
}
