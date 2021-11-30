//
//  Extensions.swift
//  NineNewsPointServices
//
//  Created by Animesh Mishra on 26/11/21.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
let networking = Networking()

extension UIImageView {
    public func loadImage(urlSting: String) {
        guard let url = URL(string: urlSting) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlSting as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }

        networking.requestImageData(url: url) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: urlSting as AnyObject)
                self.image = UIImage(data: data)
            case .failure(_):
                self.image = UIImage(named: "PlaceholderImage")
            }
        }
    }
}
