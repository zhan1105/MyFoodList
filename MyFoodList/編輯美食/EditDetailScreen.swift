//
//  AddFoodScreen.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/20.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import PhotosUI

class EditDetailScreen: MyViewController {
    
    private let titleBar = AppTitleBar()
    private let scrollView = UIScrollView()
    private var contentView: EditDetailUI!
    
    private let db = Firestore.firestore()
    
    private let uploadItem = ["相機", "相簿"]

    private var foodName =      String()
    private var minPrice =      String()
    private var maxPrice =      String()
    private var address =       String()
    private var link =          String()
    private var coordinate =    String()
    private var evaluate =      Int()
    private var picture01 =     String()
    private var picture02 =     String()
    
    private var selectImageType: UploadPictureType?
    
    var food_id = String()
    var editDetailType: EditDetailType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        if editDetailType == .Edit {
            Task { await FoodDetail_FireStore() }
        }
    }
    
    private func setUploadAction() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for item in uploadItem {
            let action = UIAlertAction(title: item, style: .default) { [weak self] _ in
                guard let self = self else { return }
                if item == "相機" {
                    self.showImagePicker()
                } else {
                    self.openPhotoAlbum()
                }
            }
            alert.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openPhotoAlbum() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1  // 限制選擇 1 張圖片
        config.filter = .images  // 只顯示圖片
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func isVerify() {
        var isValid = true
        
        for textFieldType in DetailType.allCases {
            
            let verifyText = contentView.getFieldText(textFieldType)
            var errorMessage = String()
            
            switch textFieldType {
            case .food:
                errorMessage = "美食名稱"
                foodName = verifyText ?? ""
            case .minPrice:
                errorMessage = "最低價位"
                minPrice = verifyText ?? ""
            case .maxPrice:
                errorMessage = "最高價位"
                maxPrice = verifyText ?? ""
            case .address:
                errorMessage = "地址"
                address = verifyText ?? ""
            case .link:
                errorMessage = "連結"
                link = verifyText ?? ""
            case .coordinate:
                errorMessage = "經緯度"
                coordinate = verifyText ?? ""
            }
            
            if let selectText = verifyText, selectText.isEmpty {
                showMessage(errorMessage + "不可為空")
                isValid = false
            }
        }
        
        if evaluate == 0 {
            showMessage("必須評分")
            isValid = false
        }
        
        for pictureType in UploadPictureType.allCases {
            if contentView.isUsingDefaultImage(pictureType) {
                showMessage("必須上傳兩張圖片")
                isValid = false
            } else {
                switch pictureType {
                case .First_Picture:
                    picture01 = contentView.getUploadPicture(.First_Picture).getJPEGBase64StrFromImage(maxSize: 100 * 1024)
                case .Second_Picture:
                    picture02 = contentView.getUploadPicture(.Second_Picture).getJPEGBase64StrFromImage(maxSize: 100 * 1024)
                }
            }
        }
        
        if isValid {
            if editDetailType == .Add {
                Task { await AddFoodDetail_FireStore() }
            } else {
                Task { await EditFoodDetail_FireStore() }
            }
        }
    }
}

//MARK: - UI
extension EditDetailScreen {
    func setupUI() {
        
        let width = UIScreen.main.bounds.width
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        
        titleBar.setTitle = "美食詳情"
        titleBar.setBackButtonImage = .backCircle
        titleBar.backButtonAction = { [weak self] in self?.popViewController() }
                
        contentView = EditDetailUI(width: width, height: safeAreaHeight)
        contentView.setDelegate = self
        
        contentView.setStarButtonAction(0) { [weak self] in
            guard let self = self else { return }
            self.evaluate = 1
            self.contentView.setEvaluate = evaluate
        }
        
        contentView.setStarButtonAction(1) { [weak self] in
            guard let self = self else { return }
            self.evaluate = 2
            self.contentView.setEvaluate = evaluate
        }
        
        contentView.setStarButtonAction(2) { [weak self] in
            guard let self = self else { return }
            self.evaluate = 3
            self.contentView.setEvaluate = evaluate
        }
        
        contentView.setStarButtonAction(3) { [weak self] in
            guard let self = self else { return }
            self.evaluate = 4
            self.contentView.setEvaluate = evaluate
        }
        
        contentView.setStarButtonAction(4) { [weak self] in
            guard let self = self else { return }
            self.evaluate = 5
            self.contentView.setEvaluate = evaluate
        }
        
        contentView.setUploadAction(.First_Picture) { [weak self] in
            guard let self = self else { return }
            selectImageType = .First_Picture
            self.setUploadAction()
        }
        
        contentView.setUploadAction(.Second_Picture) { [weak self] in
            guard let self = self else { return }
            selectImageType = .Second_Picture
            self.setUploadAction()
        }
        
        contentView.setNextButtonAction = { [weak self] in
            guard let self = self else { return }
            self.isVerify()
        }
                
        let appScreen = MyStack(arrangedSubviews: [titleBar, scrollView])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            scrollView.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}

//MARK: - PHPickerViewControllerDelegate
extension EditDetailScreen: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let result = results.first else { return }
        
        result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
            DispatchQueue.main.async { [self] in
                if let image = image as? UIImage {
                    self.contentView.setUploadPicture(selectImageType!, picture: image)
                }
            }
        }
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditDetailScreen: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImagePicker() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("此設備不支援該功能")
            return
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = false  // 允許編輯
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            self.contentView.setUploadPicture(selectImageType!, picture: editedImage)  // 設定圖片
        } else if let originalImage = info[.originalImage] as? UIImage {
            self.contentView.setUploadPicture(selectImageType!, picture: originalImage)
        }
        picker.dismiss(animated: true)
    }
    
    // 取消選擇
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension EditDetailScreen: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                
        let Characters = "0123456789"
        textField.autocapitalizationType = .allCharacters
        
        switch textField {
        case contentView.getTextField(.minPrice), contentView.getTextField(.maxPrice):
            
            let allowedCharacters = CharacterSet(charactersIn: Characters)
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
            
        case contentView.getTextField(.coordinate):
            
            let allowedCharacters = CharacterSet(charactersIn: "\(Characters),.() ")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        default:
            return true
        }
    }
}

//MARK: - FireStore
extension EditDetailScreen {
    
    private func FoodDetail_FireStore() async {
        
        showLoading()
        
        do {
            let data = db.collection(FireStoreKey.FoodList.rawValue).document(food_id)
            let dataResponse = try await data.getDocument()
                         
            foodName = dataResponse["Food"] as! String
            contentView.setFieldText(.food, foodName)
            
            let price = dataResponse["Price"] as! String
            let prices = price
                .split(separator: "~") // 以逗號切割
                .map { $0.trimmingCharacters(in: .whitespaces) } // 去除空白
            
            minPrice = prices[0]
            contentView.setFieldText(.minPrice, minPrice)

            maxPrice = prices[1]
            contentView.setFieldText(.maxPrice, maxPrice)

            address = dataResponse["Address"] as! String
            contentView.setFieldText(.address, address)
            
            link = dataResponse["Link"] as! String
            contentView.setFieldText(.link, link)
            
            coordinate = dataResponse["Coordinate"] as! String
            contentView.setFieldText(.coordinate, coordinate)
            
            evaluate = dataResponse["Evaluate"] as! Int
            contentView.setEvaluate = evaluate
            
            picture01 = dataResponse["Picture01"] as! String
            contentView.setUploadPicture(.First_Picture, picture: UIImage.convertStrToImage(picture01) ?? .picture)
            
            picture02 = dataResponse["Picture02"] as! String
            contentView.setUploadPicture(.Second_Picture, picture: UIImage.convertStrToImage(picture02) ?? .picture)

        } catch {
            MyPrint("Firestore 獲取詳情失敗: \(error.localizedDescription)")
        }
        
        dismissLoading()
    }

    private func AddFoodDetail_FireStore() async {
        
        showLoading()
        
        let Price_Min = Int(minPrice) ?? 0
        let Price_Max = Int(maxPrice) ?? 0
        
        let body: [String: Any] = [
            "Food":             foodName,
            "Price":            minPrice + " ~ " + maxPrice,
            "Price_Min":        Price_Min,
            "Price_Max":        Price_Max,
            "Address":          address,
            "Coordinate":       coordinate,
            "Link":             link,
            "Evaluate":         evaluate,
            "Picture01":        picture01,
            "Picture02":        picture02,
        ]
        
        do {
            let data = try await db.collection(FireStoreKey.FoodList.rawValue).addDocument(data: body)
            let documentID = data.documentID
            
            let memberID = UserDefaults.standard.string(forKey: UserDefaultsKey.user_id.rawValue) ?? ""
            let data_Member = db.collection(FireStoreKey.Member.rawValue).document(memberID)
            let dataRespone_Member = try await data_Member.getDocument()
            
            var foodList: [String] = dataRespone_Member["FoodList_ID"] as! [String]
            foodList.append(documentID)
            try await data_Member.setData(["FoodList_ID": foodList], merge: true)
            
            pushViewController(MyTabBarScreen())
            
        } catch {
            self.MyPrint("新增失敗：\(error.localizedDescription)")
        }
        
        dismissLoading()
    }
    
    private func EditFoodDetail_FireStore() async {
        
        showLoading()
        
        let Price_Min = Int(minPrice) ?? 0
        let Price_Max = Int(maxPrice) ?? 0
        
        let body: [String: Any] = [
            "Food":             foodName,
            "Price":            minPrice + " ~ " + maxPrice,
            "Price_Min":        Price_Min,
            "Price_Max":        Price_Max,
            "Address":          address,
            "Coordinate":       coordinate,
            "Link":             link,
            "Evaluate":         evaluate,
            "Picture01":        picture01,
            "Picture02":        picture02,
        ]
        
        do {
            let data = db.collection(FireStoreKey.FoodList.rawValue).document(food_id)
            try await data.updateData(body)
            
            clearToViewController(MyTabBarScreen())
            
        } catch {
            self.MyPrint("修改失敗：\(error.localizedDescription)")
        }
        
        dismissLoading()
    }
}
