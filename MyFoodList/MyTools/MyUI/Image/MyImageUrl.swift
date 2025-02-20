//
//  MyImageUrl.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/3.
//

import UIKit

class MyImageUrl: UIImageView {
    
    private var imageURL: URL?
    private var shouldCache: Bool

    var setImageURL: URL? = nil {
        didSet {
            guard let url = setImageURL else { return }
            
            if url == imageURL && shouldCache {
                return
            }
            
            imageURL = url
            loadImage(from: url)
        }
    }
    
    // MARK: - 初始化方法
    init(imageURL: URL? = nil, shouldCache: Bool = true) {
        self.shouldCache = shouldCache
        super.init(frame: .zero)
        setupUI()
        
        if let url = imageURL {
            setImageURL = url
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 設定 UI
    private func setupUI() {
        self.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - 下載圖片
    private func loadImage(from url: URL) {
        // 嘗試從快取中取得圖片
        if shouldCache, let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            if let cachedImage = UIImage(data: cachedResponse.data) {
                self.image = cachedImage
                return
            }
        }
        
        // 從網路下載圖片
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                print("zhan: 下載圖片時發生錯誤: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode),
                  let data = data,
                  let downloadedImage = UIImage(data: data) else {
                print("zhan: 下載圖片失敗或數據無效")
                return
            }
            
            // 快取下載的圖片
            if self.shouldCache, let response = response {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
            }
            
            // 在主線程更新圖片
            DispatchQueue.main.async {
                // 確保圖片 URL 未被更新
                if self.imageURL == url {
                    self.image = downloadedImage
                }
            }
        }.resume()
    }
}
