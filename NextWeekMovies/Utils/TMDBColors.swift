//
//  TMDBColors.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 24/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import Foundation
import UIKit

enum TMDBColors {
    case darkBlue
    case neonGreen
    
    var color: UIColor {
        var colorValues: (r: CGFloat, g: CGFloat, b: CGFloat) = (0,0,0)
        
        switch self {
        case .darkBlue:
            colorValues = (8, 28, 36)
        case .neonGreen:
            colorValues = (1, 210, 119)
        }
        
        colorValues = (colorValues.r / 255, colorValues.g / 255, colorValues.g / 255)
        
        return UIColor(displayP3Red: colorValues.r, green: colorValues.g, blue: colorValues.b, alpha: 1.0)
    }
}
