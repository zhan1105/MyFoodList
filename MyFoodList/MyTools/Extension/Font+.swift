//
//  UIFont+.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/12.
//

import UIKit

extension UIFont {
    
    static let largeTitle   = UIFont.preferredFont(forTextStyle: .largeTitle)
    static let title1       = UIFont.preferredFont(forTextStyle: .title1)
    static let title2       = UIFont.preferredFont(forTextStyle: .title2)
    static let title3       = UIFont.preferredFont(forTextStyle: .title3)
    static let headline     = UIFont.preferredFont(forTextStyle: .headline)
    static let body         = UIFont.preferredFont(forTextStyle: .body)
    static let callout      = UIFont.preferredFont(forTextStyle: .callout)
    static let subheadline  = UIFont.preferredFont(forTextStyle: .subheadline)
    static let footnote     = UIFont.preferredFont(forTextStyle: .footnote)
    static let caption1     = UIFont.preferredFont(forTextStyle: .caption1)
    
    static let boldLargeTitle   = UIFont.systemFont(ofSize: UIFont.largeTitle.pointSize, weight: .bold)
    static let boldTitle1       = UIFont.systemFont(ofSize: UIFont.title1.pointSize, weight: .bold)
    static let boldTitle2       = UIFont.systemFont(ofSize: UIFont.title2.pointSize, weight: .bold)
    static let boldTitle3       = UIFont.systemFont(ofSize: UIFont.title3.pointSize, weight: .bold)
    static let boldHeadline     = UIFont.systemFont(ofSize: UIFont.headline.pointSize, weight: .bold)
    static let boldBody         = UIFont.systemFont(ofSize: UIFont.body.pointSize, weight: .bold)
    static let boldCallout      = UIFont.systemFont(ofSize: UIFont.callout.pointSize, weight: .bold)
    static let boldSubheadline  = UIFont.systemFont(ofSize: UIFont.subheadline.pointSize, weight: .bold)
    static let boldFootnote     = UIFont.systemFont(ofSize: UIFont.footnote.pointSize, weight: .bold)
    static let boldCaption1     = UIFont.systemFont(ofSize: UIFont.caption1.pointSize, weight: .bold)
}
