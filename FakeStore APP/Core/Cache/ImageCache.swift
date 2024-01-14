//
//  ImageCache.swift
//  TMDB App
//
//  Created by Aleksandar Milidrag on 12/16/23.
//

import Foundation

class ImageCache {
    typealias CacheType = NSCache<NSString, NSData>
    static let shared = ImageCache()
    
    private init() {}
    
    private lazy var cache: CacheType = {
        let cache = CacheType()
        cache.countLimit = 300
        cache.totalCostLimit = 500 * 1024 * 1024
        return cache
    }()
    // Get an image
    func object(forKey key: NSString) -> Data? {
        return cache.object(forKey: key) as? Data
    }
    // Save an image
    func set(object: NSData, forKey key: NSString) {
        return cache.setObject(object, forKey: key)
    }
}
