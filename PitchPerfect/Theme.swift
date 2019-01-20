//
//  Theme+Date.swift
//  PitchPerfect
//
//  Created by Omar Namnakani on 15/01/2019.
//  Copyright © 2019 OmarNmk. All rights reserved.
//
import Foundation
import UIKit


enum ThemeStyle: String{
    case dark, light
}

extension UIViewController {
    
    var themeStyle: ThemeStyle {
        return UserDefaults.standard.currentThemeStyle()
    }
    
    func setTheme(_ themeStyle: ThemeStyle) {
        if themeStyle == .dark {
            view.backgroundColor = .darkGray
            for subview in view.subviews {
                if subview is UILabel {
                    (subview as! UILabel).textColor = .white
                }
            }
            
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = UIColor(white: 0.15, alpha: 1)
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
            navigationController?.navigationBar.barStyle = .black
            
        } else if themeStyle == .light {
            view.backgroundColor = .white
            for subview in view.subviews {
                if subview is UILabel {
                    (subview as! UILabel).textColor = .black
                }
            }
            
            navigationController?.navigationBar.tintColor = nil
            navigationController?.navigationBar.barTintColor = nil
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.titleTextAttributes = nil
            navigationController?.navigationBar.barStyle = .default
        }
    }
}



extension UIImage {
    static var sunIcon: UIImage {
        return #imageLiteral(resourceName: "sun").resizeImage(targetSize: CGSize(width: 23, height: 23))
    }
    static var moonIcon: UIImage {
        return #imageLiteral(resourceName: "moon").resizeImage(targetSize: CGSize(width: 23, height: 23))
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
