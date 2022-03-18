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
    
    private let label:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        label.textColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1.0)// to suppurt dark mode
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
    
    init(viewModel: SnackbarViewModel, frame: CGRect){
        self.viewModel = viewModel
        super.init(frame: frame)
        
        addSubview(label)
        
        if(viewModel.image != nil){
            addSubview(imageView)
        }
        
        backgroundColor = UIColor(red: 1, green: 0.4275, blue: 0.4275, alpha: 0.4)
//        layer.borderWidth = 2
//        layer.borderColor = CGColor(red: 0.7529, green: 0.2431, blue: 0.1333, alpha: 0.2)
        
        clipsToBounds = true
        layer.cornerRadius = 40
        layer.masksToBounds = true
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
