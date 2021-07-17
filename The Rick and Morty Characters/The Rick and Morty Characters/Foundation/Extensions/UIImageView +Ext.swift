//
//  UIImage+Ext.swift
//  The Rick and Morty Characters
//
//  Created by Leonardo Olivares on 17-07-21.
//

import UIKit

extension UIImageView {
    public func imageFromURL(urlString: String, withDefaultImage defaultImage: UIImage?) {
        if let defaultImage = defaultImage {
            self.image = defaultImage
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { [weak self] (data, response, error) -> Void in
            if error != nil { return }

            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self?.image = image
            })
        }).resume()
    }
}
