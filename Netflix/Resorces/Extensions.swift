//
//  Extensions.swift
//  Netflix
//
//  Created by Rohit Sharma on 31/12/22.
//

import Foundation
import UIKit

extension String {
    
    func capitalizeFirstLetterOfString() -> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    
}
