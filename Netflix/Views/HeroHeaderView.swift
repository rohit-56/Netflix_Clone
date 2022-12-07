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
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}
