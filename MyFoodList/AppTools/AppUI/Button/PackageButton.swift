//
//  AppButton.swift
//  transfer
//
//  Created by 紹郁 on 2024/9/19.
//

import UIKit

class PackageButton: UIView {
    
    private var padding: UIEdgeInsets = .zero
    private let newPackageView = UIView()
    
    private let button = MyButton()
    private var configuration = UIButton.Configuration.filled()
    
    var buttonText: LocalizedStringKey.KeyOptions = .shared(.none) {
        didSet {
            button.setTitle(.localizedString(for: buttonText), for: .normal)
        }
    }
    
    var buttonImage: UIImage? {
        didSet {
            button.setImage(buttonImage, for: .normal)
            button.backgroundColor = .clear
        }
    }
    
    var imageContentMode: UIView.ContentMode = .scaleAspectFit {
        didSet {
            button.imageView?.contentMode = imageContentMode
            setNeedsLayout()
        }
    }
    
    var buttonBackground: UIColor = .oceanBlue {
        didSet {
            button.backgroundColor = buttonBackground
        }
    }
    
    var buttonBackgroundImage: UIImage? = nil {
        didSet {
            button.setBackgroundImage(buttonBackgroundImage, for: .normal)
        }
    }
    
    var buttonAction: (() -> Void)? {
        didSet {
            button.buttonAction = buttonAction
        }
    }
    
    var buttonHidden: Bool = false {
        didSet {
            button.isHidden = buttonHidden
        }
    }
    
    var buttonEnabled: Bool = false {
        didSet {
            button.isEnabled = buttonEnabled
        }
    }
    
    var buttonBorderColor: CGColor = UIColor.skyGray.cgColor {
        didSet {
            button.layer.borderWidth = 2
            button.layer.cornerRadius = 15
            button.layer.borderColor = buttonBorderColor
        }
    }
    
    var buttonTintColor: UIColor = .white {
        didSet {
            button.tintColor = buttonTintColor
        }
    }
    
    var textColor: UIColor = .white {
        didSet {
            button.setTitleColor(textColor, for: .normal)
        }
    }
    
    var textAlignment: UIControl.ContentHorizontalAlignment = .center {
        didSet {
            button.contentHorizontalAlignment = textAlignment
        }
    }
    
    var textFont: UIFont? = .title2 {
        didSet {
            button.titleLabel?.font = textFont
        }
    }
    
    var buttonSemanticContentAttribute: UISemanticContentAttribute = .forceLeftToRight {
        didSet {
            button.semanticContentAttribute = buttonSemanticContentAttribute
        }
    }
    
    var imageTextSpacing: CGFloat = 0 {
        didSet {
            configuration.imagePadding = imageTextSpacing
            var titleTextAttributes = AttributeContainer()
            titleTextAttributes.foregroundColor = textColor
            titleTextAttributes.font = textFont
            configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { _ in
                return titleTextAttributes
            }
            configuration.background.backgroundColor = buttonBackground
            button.configuration = configuration
        }
    }
    
    init(text: LocalizedStringKey.KeyOptions = .shared(.none)){
        super.init(frame: .zero)
        setupUI(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: MyPackageImage) has not been implemented")
    }
    
    private func setupUI(text: LocalizedStringKey.KeyOptions){
        
        button.setTitle(.localizedString(for: text), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        newPackageView.addSubview(button)
        newPackageView.backgroundColor = .clear
        newPackageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(newPackageView)
        NSLayoutConstraint.activate([
            newPackageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newPackageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newPackageView.topAnchor.constraint(equalTo: topAnchor),
            newPackageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func viewPadding(to padding: CGFloat = 0,
                     top: CGFloat? = nil, bottom: CGFloat? = nil,
                     left: CGFloat? = nil, right: CGFloat? = nil){
        self.padding = UIEdgeInsets(
            top:    top     ?? padding,
            left:   left    ?? padding,
            bottom: bottom  ?? padding,
            right:  right   ?? padding
        )
        
        NSLayoutConstraint.deactivate(button.constraints) // 清除舊約束
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: newPackageView.topAnchor, constant: self.padding.top),
            button.bottomAnchor.constraint(equalTo: newPackageView.bottomAnchor, constant: -self.padding.bottom),
            button.leadingAnchor.constraint(equalTo: newPackageView.leadingAnchor, constant: self.padding.left),
            button.trailingAnchor.constraint(equalTo: newPackageView.trailingAnchor, constant: -self.padding.right)
        ])
    }
    
    func setButtonContentInsets(to content: CGFloat = 0,
                                top: CGFloat? = nil, bottom: CGFloat? = nil,
                                leading: CGFloat? = nil, trailing: CGFloat? = nil){
        
        configuration.contentInsets = NSDirectionalEdgeInsets(top:         top         ?? content,
                                                              leading:     leading     ?? content,
                                                              bottom:      bottom      ?? content,
                                                              trailing:    trailing    ?? content)
        button.configuration = configuration
    }
}
