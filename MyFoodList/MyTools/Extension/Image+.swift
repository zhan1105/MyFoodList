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
        guard let data = self.pngData() else { return "" }
        return data.base64EncodedString(options: .endLineWithLineFeed)
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
    
    func getJPEGBase64StrFromImage(maxSize: Int, compressionQuality: CGFloat = 0.9) -> String {
        var quality = compressionQuality
        var data = self.jpegData(compressionQuality: quality)
        
        // 若 data 超過 maxSize，則逐步降低品質進行壓縮
        while let d = data, d.count > maxSize, quality > 0.1 {
            quality -= 0.1
            data = self.jpegData(compressionQuality: quality)
        }
        
        guard let finalData = data else { return "" }
        return finalData.base64EncodedString(options: .endLineWithLineFeed)
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
