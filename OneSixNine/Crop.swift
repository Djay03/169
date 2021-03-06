//
//  Crop.swift
//  OneSixNine
//
//  Created by ray on 11/01/2017.
//  Copyright © 2017 Ray. All rights reserved.
//

import UIKit

extension UIImage {
    func crop( rect: CGRect) -> UIImage {
        var rect = rect
        rect.origin.x*=self.scale
        rect.origin.y*=self.scale
        rect.size.width*=self.scale
        rect.size.height*=self.scale
        
        print(rect.origin)
        print(rect.size)
        print(self.scale)
        
        let imageRef = self.cgImage!.cropping(to: rect)
        let image = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
        return image
    }
}
