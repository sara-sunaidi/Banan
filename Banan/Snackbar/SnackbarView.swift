//
//  SnackbarView.swift
//  Banan
//
//  Created by Madawi Ahmed on 15/08/1443 AH.
//

import UIKit

class SnackbarView: UIView {
    
    let viewModel:SnackbarViewModel
    
    private let label:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = UIColor(red: 221/255, green: 25/255, blue: 15/255, alpha: 1.0)// to suppurt dark mode
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
        
        backgroundColor = UIColor(red: 221/255, green: 25/255, blue: 15/255, alpha: 0.15)
        layer.borderWidth = 2
        layer.borderColor = CGColor(red: 221/255, green: 25/255, blue: 15/255, alpha: 0.8)
        
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
            imageView.frame = CGRect(x: 10, y: 10, width: frame.height - 10, height: frame.height - 20)
            label.frame = CGRect(x: imageView.frame.size.width,
                                 y: 0,
                                 width: frame.size.width - imageView.frame.size.width,
                                 height: frame.size.height)
            
        } else {
            label.frame = bounds
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
