//
//  PictureFieldUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/3.
//

import UIKit

class PictureFieldUI: UIView {

    private let titleLabel = MyLabel()
    private let pictureButton = MyPackageButton()
    
    var setTitle: String? = nil {
        didSet {
            titleLabel.text = setTitle
        }
    }
    
    var setContentImage: UIImage? = nil {
        didSet {
            pictureButton.buttonImage = setContentImage
        }
    }
    
    var buttonAction: (() -> Void)? {
        didSet {
            pictureButton.buttonAction = buttonAction
        }
    }
    
    var isUsingDefaultImage: Bool {
        return pictureButton.buttonImage == .picture
    }
    
    func getContentImage() -> UIImage? {
        if let image = pictureButton.buttonImage {
            return image
        } else {
            return nil
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: PictureFieldUI) has not been implemented")
    }
    
    private func setupUI(){
                
        titleLabel.font = .boldHeadline
        titleLabel.textAlignment = .left
        
        pictureButton.buttonText = ""
        pictureButton.buttonImage = .picture
        pictureButton.buttonBackgroundImage = .uploadfilesDefault
        pictureButton.viewPadding()
        
        let spacer = MySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [titleLabel, pictureButton, spacer])
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.15),
            pictureButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.75),
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1)
        ])
    }
}
