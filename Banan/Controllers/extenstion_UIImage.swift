//
//  extension_UIImage.swift
//  OpenCVTest
//
//  Created by Timothy Poulsen on 11/29/18.
//  Copyright © 2018 Timothy Poulsen. All rights reserved.
//

import UIKit

extension UIImage {
    func resizeTo(height: CGFloat? = nil, width: CGFloat? = nil) -> UIImage? {
        var newHeight:CGFloat = 100.0
        var newWidth:CGFloat = 100.0

        if let h = height {
            // resize using height
            let scale = h / self.size.height
            newHeight = h
            newWidth = self.size.width * scale
        } else if let w = width {
            // resize using width
            let scale = w / self.size.width
            newHeight = self.size.height * scale
            newWidth = w
        }
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    var has_alpha: Bool {
        guard let cg = self.cgImage else { return false }
        let alpha = cg.alphaInfo
        return (alpha == .first || alpha == .last || alpha == .premultipliedFirst || alpha == .premultipliedLast)
    }

    var normalized: UIImage? {
        // https://stackoverflow.com/a/34648079/292947
        if self.imageOrientation == .up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, !self.has_alpha, self.scale)
        var rect = CGRect.zero
        rect.size = self.size
        self.draw(in: rect)
        let retVal = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return retVal
    }
}
