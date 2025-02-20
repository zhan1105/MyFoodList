//
//  MyViewButton.swift
//  transfer
//
//  Created by 紹郁 on 2024/9/11.
//

import UIKit

class MyImageButton: UIButton {
    
    var buttonAction: (() -> Void)?
    
    var setContentMode: UIView.ContentMode = .scaleAspectFit {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    var setContentImage: UIImage? = nil {
        didSet {
            self.setImage(setContentImage, for: .normal)
        }
    }
    
    init(image: UIImage? = nil) {
        super.init(frame: .zero)
        setupUI(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(image: UIImage?) {
        self.setImage(image, for: .normal)
        self.setTitle("", for: .normal)
        self.tintColor = .clear
        self.backgroundColor = .clear
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.contentMode = setContentMode
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
    }
}
