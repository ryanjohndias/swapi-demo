//
//  UIImageView.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/28.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadImage(fromURL urlString: String, fadeIn: Bool = false) {
        
        guard let url = URL(string: urlString) else {
            print("Could not create URL from string '\(urlString)'")
            return
        }
        
        if fadeIn {
            alpha = 0
        }
        
        let getImageTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Error occurred with the download
            if let error = error {
                print("An error occurred while attempting to download image from '\(urlString)':\n\(error.localizedDescription)")
                
            }
                
                // Download successful
            else {
                
                if let _ = response as? HTTPURLResponse, let data = data {
                    
                    // Set the image on the main (UI) thread
                    if let actualImage = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.image = actualImage
                            if fadeIn {
                                UIView.animate(withDuration: 0.5, animations: {
                                    self.alpha = 1
                                })
                            }
                        }
                    }
                }
            }
            
        }
        
        getImageTask.resume()
    }
    
}
