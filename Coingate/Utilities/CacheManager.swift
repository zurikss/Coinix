//
//  CacheManager.swift
//  Coingate
//
//  Created by Victor on 05/11/2023.
//

import Foundation
import UIKit

class CacheManager {
    static let instance = CacheManager()
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        // customizing our cache
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 //100mb
        return cache
    }()

    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Added to cache"
    }
    
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from cache"
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }

}
