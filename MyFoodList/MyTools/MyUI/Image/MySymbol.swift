//
//  MySymbol.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MySymbol: UIImageView {

    init(symbol: SFSymbol = .bell) {
        super.init(frame: .zero)
        setupUI(symbol: symbol)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(symbol: SFSymbol) {
        self.image = UIImage(systemSymbol: symbol)
//        let paletteConfiguration = UIImage.SymbolConfiguration(paletteColors: [UIColor.orange, UIColor.black])
//        self.image?.withConfiguration(paletteConfiguration)
        self.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
