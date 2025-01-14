//
//  Utilities.swift
//  FlickrInterview
//
//  Created by Saideep Reddy Talusani on 1/14/25.
//
import UIKit
class Cache{
    private let cache = NSCache<NSString, UIImage>()
    static let shared = Cache()
    private init(){ }
    
    func getData(key: String)-> UIImage?{
        return cache.object(forKey: key as NSString)
    }
    
    func setData(imageData: UIImage, forKey: String){
        cache.setObject(imageData, forKey: forKey as NSString)
    }
}
