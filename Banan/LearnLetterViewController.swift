//
//  LearnLetterViewController.swift
//  Banan
//
//  Created by Noura  on 10/08/1443 AH.
//

//import Foundation
import UIKit
import SwiftUI


class LearnLetterViewController: UIViewController {
    
    @IBOutlet weak var progressView1: UIProgressView!
    //    private let progressView: UIProgressView = {
//        let progressView = UIProgressView(progressViewStyle: .bar)
//        progressView.trackTintColor = .gray
//        progressView.progressTintColor = UIColor(named: "Color")
//        progressView.transform = progressView.transform.scaledBy(x: 1, y: 20)
//
//        return progressView
//    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // progressView1.frame = CGRect(x: 50, y: 20, width: 1000, height: 100)
        // Set the rounded edge for the outer bar
        progressView1.layer.cornerRadius = 15
        progressView1.clipsToBounds = true
        
        // Set the rounded edge for the inner bar
        progressView1.layer.sublayers![1].cornerRadius = 15
        progressView1.subviews[1].clipsToBounds = true
        
        progressView1.transform = CGAffineTransform(rotationAngle: .pi);

//        UIProgressView.appearance().semanticContentAttribute = .forceLeftToRight
        progressView1.setProgress(0.3, animated: false)
    }
    
   
}
