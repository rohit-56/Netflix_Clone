//
//  HeroHeaderView.swift
//  Netflix
//
//  Created by Rohit Sharma on 07/12/22.
//

import Foundation
import UIKit

class HeroHeaderView : UIView {
    
    let imageView : UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "caro1")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let playButton : UIButton = {
       let playButton = UIButton()
        playButton.backgroundColor = .black
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.setTitle("Play", for: .normal)
        return playButton
    }()
    
    let downloadButton : UIButton = {
        let downloadButton = UIButton()
        downloadButton.backgroundColor = .black
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.layer.borderWidth = 1
        downloadButton.layer.borderColor = UIColor.white.cgColor
        downloadButton.setTitle("Download", for: .normal)
         return downloadButton
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = bounds
        
        
        addSubview(imageView)
        addSubview(playButton)
        addSubview(downloadButton)
        setComponentsConstraints()
        applyGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
 
    func setComponentsConstraints(){
       let playButtonConstraints = [
        playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
        playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
        playButton.widthAnchor.constraint(equalToConstant: 100),
        playButton.heightAnchor.constraint(equalToConstant: 40)
       ]
        
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            downloadButton.widthAnchor.constraint(equalToConstant: 100),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    func applyGradient(){
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor.black.cgColor,
            UIColor.clear.cgColor
        ]
        
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
}
