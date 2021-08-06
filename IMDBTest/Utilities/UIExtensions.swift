//
//  UIExtensions.swift
//  IMDBTest
//
//  Created by Antonio Flores on 05/08/21.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String, mode: ContentMode? = .scaleAspectFill) {
        guard let url = URL(string: urlString) else { return }
        guard let safeMode = mode else { return }
        self.contentMode = safeMode
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
        }).resume()
    }
}

extension UIViewController {
    func getStoryBoard() -> UIStoryboard {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard
    }
}
