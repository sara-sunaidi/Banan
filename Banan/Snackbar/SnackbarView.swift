//
//  SnackbarView.swift
//  Banan
//
//  Created by Madawi Ahmed on 15/08/1443 AH.
//

import UIKit
import AVFoundation

class SnackbarView: UIView {
    
    let viewModel:SnackbarViewModel
    
    enum color {
        case red
        case yellow
        case green
    }
    
    private let label:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(red: 0.1882, green: 0.1843, blue: 0.0471, alpha: 1.0)
//        UIColor(red: 0.6, green: 0, blue: 0, alpha: 1.0)// to suppurt dark mode
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
        }()
    
    private lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
        }()
    
    init(viewModel: SnackbarViewModel, frame: CGRect , color: color){
        self.viewModel = viewModel
        super.init(frame: frame)
        
        addSubview(label)
        
        if(viewModel.image != nil){
            addSubview(imageView)
        }
        switch color {
        case .red:
            backgroundColor = UIColor(red: 1, green: 0.4275, blue: 0.4275, alpha: 0.4)
            label.textColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1.0)
        case .yellow:
            backgroundColor = UIColor(red: 0.9294, green: 0.8, blue: 0.4549, alpha: 0.7)
            label.textColor = UIColor(red: 0.6196, green: 0.4314, blue: 0, alpha: 1.0)
            
        case .green:
            backgroundColor = UIColor(red: 121/255, green: 166/255, blue: 143/255, alpha: 0.7)
            label.textColor = UIColor(red: 35/255, green: 66/255, blue: 68/255, alpha: 1.0)
        }
       
        
        clipsToBounds = true
        layer.cornerRadius = 30
        layer.masksToBounds = true
//        layer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 50).cgPath
        layer.shadowColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//        layer.shadowPath = layer.path
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 30
        
        configure()
    }
    
    private func configure(){
        label.text = viewModel.text
        imageView.image = viewModel.image
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (viewModel.image != nil){
          
            imageView.frame = CGRect(x: frame.size.width - frame.height - 10, y: 10, width: frame.height - 10, height: frame.height - 20)
            label.frame = CGRect(x: 0,
                                 y: 0,
                                 width: frame.size.width - imageView.frame.size.width,
                                 height: frame.size.height)
            
            
            
//            imageView.frame = CGRect(x: 10, y: 10, width: frame.height - 10, height: frame.height - 20)
//            label.frame = CGRect(x: imageView.frame.size.width,
//                                 y: 0,
//                                 width: frame.size.width - imageView.frame.size.width,
//                                 height: frame.size.height)
//
        } else {
            label.frame = bounds
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
