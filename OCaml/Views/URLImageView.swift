/*
*  Copyright (C) 2021 Groupe MINASTE
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with this program; if not, write to the Free Software Foundation, Inc.,
* 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*
*/

import Foundation
import UIKit

class URLImageView: UIImageView {
    
    static var cache = NSCache<NSString, UIImage>()
    var task: URLSessionDataTask!
    
    func loadImage(url: String) {
        image = nil
        
        if let task = task {
            task.cancel()
        }
        
        if let imageUrl = URL(string: url) {
            if let imageFromCache = URLImageView.cache.object(forKey: imageUrl.absoluteString as NSString) {
                self.image = imageFromCache
                return
            }
            
            task = URLSession.shared.dataTask(with: imageUrl) { (data: Data?, response: URLResponse?, error: Error?) in
                guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200, let mimeType = response?.mimeType, mimeType.hasPrefix("image"), let data = data, error == nil, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async() {
                    URLImageView.cache.setObject(image, forKey: imageUrl.absoluteString as NSString)
                    self.image = image
                }
            }
            task.resume()
        }
    }

}
