//
//  EditDetailUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/27.
//

import UIKit

class EditDetailUI: UIView {
    
    private let foodField = FoodFieldUI()
    private let phoneField = FoodFieldUI()
    private let addressField = FoodFieldUI()
    private let linkField = FoodFieldUI()

    private let priceField = PriceFieldUI()
    private let coordinateField = CoordinateFieldUI()

    private var evaluateButton: EvaluateButtonUI!
    
    private let onePictureField = PictureFieldUI()
    private let twoPictureField = PictureFieldUI()
    
    private let infoStack = MyStack()
    
    private let nextButton = MyPackageButton()
    
    var setDelegate: UITextFieldDelegate? = nil {
        didSet {
            foodField.setDelegate = setDelegate
            priceField.setDelegate = setDelegate
            phoneField.setDelegate = setDelegate
            addressField.setDelegate = setDelegate
            coordinateField.setDelegate = setDelegate
        }
    }
    
    var setNextButtonAction: (() -> Void)? = nil {
        didSet {
            nextButton.buttonAction = setNextButtonAction
        }
    }
    
    var setEvaluate: Int = 0 {
        didSet {
            evaluateButton.setEvaluate = setEvaluate
        }
    }
    
    func setStarButtonAction(_ index: Int, buttonAction: (() -> Void)?) {
        evaluateButton.setStarButtonAction(index, buttonAction: buttonAction)
    }
    
    func getTextField(_ type: DetailType) -> UITextField {
        switch type {
        case .food:
            return foodField.newTextField
        case .minPrice:
            return priceField.minTextField
        case .maxPrice:
            return priceField.maxTextField
        case .phoneNumber:
            return phoneField.newTextField
        case .address:
            return addressField.newTextField
        case .lat:
            return coordinateField.latTextField
        case .lng:
            return coordinateField.lngTextField
        case .link:
            return linkField.newTextField
        }
    }
    
    func getFieldText(_ type: DetailType) -> String? {
        switch type {
        case .food:
            return foodField.fieldText
        case .minPrice:
            return priceField.minFieldText
        case .maxPrice:
            return priceField.maxFieldText
        case .phoneNumber:
            return phoneField.fieldText
        case .address:
            return addressField.fieldText
        case .lat:
            return coordinateField.latFieldText
        case .lng:
            return coordinateField.lngFieldText
        case .link:
            return linkField.fieldText
        }
    }
    
    func setFieldText(_ type: DetailType, _ text: String) {
        switch type {
        case .food:
            foodField.fieldText = text
        case .minPrice:
            priceField.minFieldText = text
        case .maxPrice:
            priceField.maxFieldText = text
        case .phoneNumber:
            phoneField.fieldText = text
        case .address:
            addressField.fieldText = text
        case .lat:
            coordinateField.latFieldText = text
        case .lng:
            coordinateField.lngFieldText = text
        case .link:
            linkField.fieldText = text
        }
    }
    
    func setUploadAction(_ index: Int, action: (() -> Void)?) {
        let pictureField = index == 0 ? onePictureField : twoPictureField
        pictureField.buttonAction = action
    }
    
    func setUploadPicture(_ index: Int, picture: UIImage) {
        let pictureField = index == 0 ? onePictureField : twoPictureField
        pictureField.setContentImage = picture
    }
    
    func getUploadPicture(_ index: Int) -> UIImage {
        let pictureField = index == 0 ? onePictureField : twoPictureField
        return pictureField.getContentImage() ?? .picture
    }
    
    func isUsingDefaultImage(_ index: Int) -> Bool {
        let pictureField = index == 0 ? onePictureField : twoPictureField
        return pictureField.isUsingDefaultImage
    }
    
    init(width: CGFloat, height: CGFloat){
        super.init(frame: .zero)
        setupUI(width: width, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: EditDetailUI) has not been implemented")
    }
    
    private func setupUI(width: CGFloat, height: CGFloat){
        
        foodField.setTitle = "美食名稱："
        phoneField.setTitle = "電話："
        phoneField.setKeyboardType = .phonePad
        addressField.setTitle = "地址："
        linkField.setTitle = "連結："
        
        evaluateButton = EvaluateButtonUI(spacing: width * 0.025)
        
        onePictureField.setTitle = "圖片1："
        twoPictureField.setTitle = "圖片2："
                
        let foodFields: [FoodFieldUI] = [foodField, phoneField, addressField, linkField]
        foodFields.forEach {
            $0.widthAnchor.constraint(equalToConstant: width * 0.825).isActive = true
            $0.heightAnchor.constraint(equalToConstant: height * 0.125).isActive = true
        }
        
        let pictureFields: [PictureFieldUI] = [onePictureField, twoPictureField]
        pictureFields.forEach {
            $0.widthAnchor.constraint(equalToConstant: width * 0.825).isActive = true
            $0.heightAnchor.constraint(equalToConstant: height * 0.29375).isActive = true
        }
        
        let spacer = MySpacer()
        
        infoStack.addArrangedSubviews([spacer,
                                       foodField, priceField, phoneField, addressField, coordinateField, linkField,
                                       evaluateButton,
                                       onePictureField, twoPictureField])
        infoStack.alignment = .center
        infoStack.layer.cornerRadius = 10
        infoStack.backgroundColor = .lightGrayWhite
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spacer.heightAnchor.constraint(equalToConstant: height * 0.0125),

            priceField.widthAnchor.constraint(equalToConstant: width * 0.825),
            priceField.heightAnchor.constraint(equalToConstant: height * 0.125),

            coordinateField.widthAnchor.constraint(equalToConstant: width * 0.825),
            coordinateField.heightAnchor.constraint(equalToConstant: height * 0.125),
            
            evaluateButton.widthAnchor.constraint(equalToConstant: width * 0.825),
            evaluateButton.heightAnchor.constraint(equalToConstant: height * 0.15),
        ])
        
        let topSpacer = MySpacer()
        let bottomSpacer = MySpacer()

        nextButton.buttonText = "確認"
        nextButton.textFont = .boldTitle2
        nextButton.buttonCornerRadius = 15
        nextButton.viewPadding(to: width * 0.05)
        
        let subScreen = MyStack(arrangedSubviews: [topSpacer, infoStack, bottomSpacer, nextButton])
        subScreen.alignment = .center
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            topSpacer.heightAnchor.constraint(equalToConstant: height * 0.025),

            infoStack.widthAnchor.constraint(equalToConstant: width * 0.9),
            infoStack.heightAnchor.constraint(equalToConstant: height * 1.5),
            
            bottomSpacer.heightAnchor.constraint(equalToConstant: height * 0.025),

            nextButton.widthAnchor.constraint(equalToConstant: width),
            nextButton.heightAnchor.constraint(equalToConstant: height * 0.1125)
        ])
    }
}
