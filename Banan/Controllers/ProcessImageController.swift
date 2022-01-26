//
//  ProcessImageController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 26/01/2022.
//

//import Foundation
import UIKit

class ProcessImageController: UIViewController{
    public var source_image: UIImage? = nil
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let src_img = self.source_image {
            showImage(image: src_img)
        }
    }
    
  
    @IBAction func processImage(_ sender: UIButton) {
        
        if let img = self.source_image {
//            showImage(image: OpenCVWrapper.detectEdges(inRGBImage: img.normalized!))
        }
    }
    
    
    func showImage(image: UIImage) {
        //if let resized = image.
        imgView.image = image
//        if let resized = image.resizeTo(width: imgView?.frame.width) {
//            imgView.image = resized
//        }
    }
    
    
}
