//
//  EvaluateUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/27.
//

import UIKit

class EvaluateImageUI: UIView {

    private let oneStarImage = MyPackageImage()
    private let twoStarImage = MyPackageImage()
    private let threeStarImage = MyPackageImage()
    private let fourStarImage = MyPackageImage()
    private let fiveStarImage = MyPackageImage()

    var setEvaluate: Int = 0 {
        didSet {
            let starImages: [MyPackageImage] = [oneStarImage, twoStarImage, threeStarImage, fourStarImage, fiveStarImage]            
            starImages.enumerated().forEach { index, starImage in
                if index + 1 <= setEvaluate {
                    starImage.setImage = .starSelected
                }
            }
        }
    }
    
    func viewPadding(to padding: CGFloat = 0,
                     top: CGFloat? = nil, bottom: CGFloat? = nil,
                     left: CGFloat? = nil, right: CGFloat? = nil){

        let topPadding: CGFloat = top ?? padding
        let bottomPadding: CGFloat = bottom ?? padding
        let leftPadding: CGFloat = left ?? padding
        let rightPadding: CGFloat = right ?? padding
                
        let starImages: [MyPackageImage] = [oneStarImage, twoStarImage, threeStarImage, fourStarImage, fiveStarImage]
        starImages.forEach {
            $0.viewPadding(top: topPadding, bottom: bottomPadding, left: leftPadding, right: rightPadding)
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: EvaluateUI) has not been implemented")
    }
    
    private func setupUI(){
        
        let starImages: [MyPackageImage] = [oneStarImage, twoStarImage, threeStarImage, fourStarImage, fiveStarImage]
        starImages.forEach {
            $0.setImage = .starUnSelected
        }
        
        let subScreen = MyStack(arrangedSubviews: starImages)
        subScreen.axis = .horizontal
        subScreen.distribution = .fillEqually
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
