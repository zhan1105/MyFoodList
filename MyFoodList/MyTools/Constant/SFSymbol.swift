//
//  SFSymbol.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/14.
//

import UIKit
import Foundation

enum SFSymbol: String {
    case home               = "house"
    case list               = "list.bullet"
    case gearshape          = "gearshape.fill"
    case arrow_left         = "arrowtriangle.left.fill"
    case arrow_right        = "arrowtriangle.right.fill"
    case bell_not           = "bell"
    case bell               = "bell.badge"
    case ellipsis           = "ellipsis.circle"
    case camera             = "camera.circle.fill"
    case arrow_camera       = "arrow.triangle.2.circlepath.camera.fill"
    case arrow_down         = "arrow.down"
    case location           = "location.fill"
    case search             = "magnifyingglass"
    case ellipsis_fill      = "ellipsis.circle.fill"
}

extension UIImage {
    convenience init?(systemSymbol: SFSymbol) {
        self.init(systemName: systemSymbol.rawValue)
    }
}

extension UIButton {
    func setSymbolImage(_ symbol: SFSymbol, for state: UIControl.State) {
        self.setImage(UIImage(systemSymbol: symbol), for: state)
    }
    
    func setSymbolConfiguration(_ symbol: SFSymbol,  size: CGFloat, for state: UIControl.State) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: size, weight: .bold, scale: .large)
        self.setImage(UIImage(systemSymbol: symbol)?.withConfiguration(largeConfig), for: state)
    }
}
