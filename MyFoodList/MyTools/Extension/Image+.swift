//
//  Image+.swift
//  transfer
//
//  Created by 紹郁 on 2024/10/4.
//

import UIKit
import Foundation

extension UIImage {
    func fixOrientation() -> UIImage {
        if imageOrientation == .up { return self }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return normalizedImage ?? self
    }
    
    //UIImage 轉 Base64
    func getPNGBase64StrFromImage() -> String {
        let dataTmp = self.pngData()
        if let data = dataTmp {
            let imageStrTT = data.base64EncodedString()
            return imageStrTT
        }
        return ""
    }
    
    //Base64轉UIImage
    func convertStrToImage(_ imageStr:String) -> UIImage? {
        if let data: Data =
            Data(base64Encoded: imageStr,
                 options:Data.Base64DecodingOptions.ignoreUnknownCharacters){
            if let image: UIImage = UIImage(data: data as Data){
                return image
            }
        }
        return nil
    }
}

extension UIImageView {
    var setImageCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }
}
