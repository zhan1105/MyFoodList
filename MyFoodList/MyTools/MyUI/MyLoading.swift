//
//  MyLoading.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/4.
//

import UIKit

class MyLoading: UIView {
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        indicator.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private var showMessageLabel: MyLabel = {
        let newLabel = MyLabel(text: "Loading...")
        newLabel.textColor = .black
        newLabel.font = UIFont.headline
        
        return newLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        let loadingView = MyStack(arrangedSubviews: [activityIndicator, showMessageLabel])
        loadingView.backgroundColor = .white
        loadingView.layer.cornerRadius = 10
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black.withAlphaComponent(0.7)
        backgroundView.addSubview(loadingView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: 175),
            loadingView.heightAnchor.constraint(equalToConstant: 125),
            
            activityIndicator.heightAnchor.constraint(equalTo: loadingView.heightAnchor, multiplier: 0.6),
            activityIndicator.topAnchor.constraint(equalTo: loadingView.topAnchor, constant: 10),
            showMessageLabel.heightAnchor.constraint(equalTo: loadingView.heightAnchor, multiplier: 0.4),
            showMessageLabel.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor, constant: 20)
        ])
    }
    
    func show(in view: UIView) {
        self.frame = view.bounds
        view.addSubview(self)
        activityIndicator.startAnimating()
    }
    
    func hide() {
        activityIndicator.stopAnimating()
        self.removeFromSuperview()
    }
}
