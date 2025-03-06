//
//  EvaluateButtonUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/27.
//

import UIKit

class EvaluateButtonUI: UIView {

    private let titleLabel = MyLabel()
    
    private let oneStarButton = MyImageButton()
    private let twoStarButton = MyImageButton()
    private let threeStarButton = MyImageButton()
    private let fourStarButton = MyImageButton()
    private let fiveStarButton = MyImageButton()

    private let evaluateView = MyStack()
    
    private var padding: UIEdgeInsets = .zero

    var setEvaluate: Int = 0 {
        didSet {
            let starButtons: [MyImageButton] = [oneStarButton, twoStarButton, threeStarButton, fourStarButton, fiveStarButton]
            starButtons.enumerated().forEach { index, starButton in
                starButton.setContentImage = index + 1 <= setEvaluate ? .starSelected : .starUnSelected
            }
        }
    }
    
    func setStarButtonAction(_ index: Int, buttonAction: (() -> Void)?) {
        let starButtons: [MyImageButton] = [oneStarButton, twoStarButton, threeStarButton, fourStarButton, fiveStarButton]
        
        guard index >= 0, index <= starButtons.count else { return } // 確保 index 在合法範圍內
        starButtons[index].buttonAction = buttonAction
    }
    
    init(spacing: CGFloat = 0){
        super.init(frame: .zero)
        setupUI(spacing: spacing)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: EvaluateUI) has not been implemented")
    }
    
    private func setupUI(spacing: CGFloat = 0){
                
        titleLabel.text = "評論："
        titleLabel.font = .boldBody
        titleLabel.textAlignment = .left
        
        let starImages: [MyImageButton] = [oneStarButton, twoStarButton, threeStarButton, fourStarButton, fiveStarButton]
        starImages.forEach {
            $0.setContentImage = .starUnSelected
        }
        
        evaluateView.addArrangedSubviews(starImages)
        evaluateView.axis = .horizontal
        evaluateView.spacing = spacing
        evaluateView.distribution = .fillEqually
        evaluateView.translatesAutoresizingMaskIntoConstraints = false
        
        let spacer = MySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [titleLabel, evaluateView, spacer])
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.4),
            evaluateView.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.45),
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.15)
        ])
    }
}
