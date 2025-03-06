//
//  PictureFieldUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/3.
//

import UIKit

class PictureFieldUI: UIView {

    private let titleLabel = MyLabel()
    private let backgroundImage = MyImage()
    private let pictureButton = MyButton()
    
    var setTitle: String? = nil {
        didSet {
            titleLabel.text = setTitle
        }
    }
    
    var setContentImage: UIImage? = nil {
        didSet {
            pictureButton.setImage(setContentImage, for: .normal)
            pictureButton.setImage(setContentImage, for: .highlighted)
        }
    }
    
    var buttonAction: (() -> Void)? {
        didSet {
            pictureButton.buttonAction = buttonAction
        }
    }
    
    var isUsingDefaultImage: Bool {
        return pictureButton.imageView?.image == .picture
    }
    
    func getContentImage() -> UIImage? {
        if let image = pictureButton.imageView?.image {
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
        
        backgroundImage.image = .uploadfilesDefault
        backgroundImage.contentMode = .scaleToFill
        backgroundImage.addSubview(pictureButton)
        backgroundImage.isUserInteractionEnabled = true
        
        pictureButton.setImage(.picture, for: .normal)
        pictureButton.setImage(.picture, for: .highlighted)
        pictureButton.backgroundColor = .clear

        let spacer = MySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [titleLabel, backgroundImage, spacer])
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.15),
            backgroundImage.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.75),
            
            pictureButton.topAnchor.constraint(equalTo: backgroundImage.topAnchor),
            pictureButton.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            pictureButton.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            pictureButton.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
            
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1)
        ])
    }
}
