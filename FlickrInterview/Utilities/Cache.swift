//
//  Utilities.swift
//  FlickrInterview
//
//  Created by Saideep Reddy Talusani on 12/3/24.
//
import UIKit
class Utilities{
    private let cache = NSCache<NSString, UIImage>()
    static let shared = Utilities()
    private init(){ }
    
    func getData(key: String)-> UIImage?{
        return cache.object(forKey: key as NSString)
    }
    
    func setData(imageData: UIImage, forKey: String){
        cache.setObject(imageData, forKey: forKey as NSString)
    }
}
