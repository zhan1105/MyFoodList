//
//  FoodDetailBannerUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/13.
//

import UIKit
import FSPagerView

class FoodDetailBannerUI: UIView {

    private(set) var pagerView = FSPagerView()
    var pageControl = FSPageControl()
    
    var setBannerIsInfinite: Bool = false {
        didSet {
            pagerView.isInfinite = setBannerIsInfinite
        }
    }
    
    var setBannerCurrentPage: Int = 0 {
        didSet {
            pageControl.currentPage = setBannerCurrentPage
        }
    }
    
    var setBannerTotalPage: Int = 0 {
        didSet {
            pageControl.numberOfPages = setBannerTotalPage
        }
    }
    
    func setDelegate(_ delegate: FSPagerViewDelegate & FSPagerViewDataSource) {
        pagerView.delegate = delegate
        pagerView.dataSource = delegate
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func reloadDataBanner() {
        pagerView.reloadData()
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: HomeBannerUI) has not been implemented")
    }

    private func setupUI(){
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        setPagerView()
        setPageControl()
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        let pagerPackageView = MyView(addSubview: pagerView)
        NSLayoutConstraint.activate([
            pagerView.centerXAnchor.constraint(equalTo: pagerPackageView.centerXAnchor),
            pagerView.centerYAnchor.constraint(equalTo: pagerPackageView.centerYAnchor),
            pagerView.widthAnchor.constraint(equalToConstant: width * 0.925),
            pagerView.topAnchor.constraint(equalTo: pagerPackageView.topAnchor, constant: height * 0.02),
            pagerView.bottomAnchor.constraint(equalTo: pagerPackageView.bottomAnchor),
        ])
        
        let subScreen = MyStack(arrangedSubviews: [pagerPackageView, pageControl])
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            pagerPackageView.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.9),
            pageControl.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1)
        ])
    }
}

//MARK: - PagerView
extension FoodDetailBannerUI {
    
    func setPagerView(){
        pagerView.automaticSlidingInterval = 3.0
        pagerView.isInfinite = setBannerIsInfinite
        pagerView.decelerationDistance = 0
        pagerView.itemSize = CGSize(width: frame.width, height: frame.height)
        pagerView.interitemSpacing = 0
        pagerView.translatesAutoresizingMaskIntoConstraints = false
        
        pagerView.transformer = FSPagerViewTransformer(type: .crossFading)
    }
}

//MARK: - PageControl
extension FoodDetailBannerUI {
    
    func setPageControl() {
        pageControl.currentPage = 0
        pageControl.contentHorizontalAlignment = .center
        pageControl.setFillColor(.softGray, for: .normal)
        pageControl.setFillColor(.oceanBlue, for: .selected)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
    }
}
