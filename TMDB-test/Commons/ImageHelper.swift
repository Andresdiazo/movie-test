//
//  ImageHelper.swift
//  TMDB-test
//
//  Created by Andres Diaz  on 23/05/23.
//

import Foundation
import UIKit
class ImageHelper {
    static func loadImage( baseimageURL: String = "https://image.tmdb.org/t/p/w500" , from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: baseimageURL + urlString) else {
            completion(nil)
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else {
                completion(nil)
                return
            }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
