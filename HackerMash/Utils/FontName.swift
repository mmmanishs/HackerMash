//
//  FontName.swift
//  HackerMash
//
//  Created by Manish Singh on 3/10/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

enum FontName {
    case HelveticaNeue_Bold
    case HelveticaNeue_CondensedBlack
    case HelveticaNeue_Medium
    case HelveticaNeue
    case HelveticaNeue_Light
    case HelveticaNeue_CondensedBold
    case HelveticaNeue_LightItalic
    case HelveticaNeue_UltraLightItalic
    case HelveticaNeue_UltraLight
    case HelveticaNeue_BoldItalic
    case HelveticaNeue_Italic
    
    func getString() -> String {
        switch self {
        case .HelveticaNeue_Bold: return "HelveticaNeue-Bold"
        case .HelveticaNeue_CondensedBlack: return "HelveticaNeue-CondensedBlack"
        case .HelveticaNeue_Medium: return "HelveticaNeue-Medium"
        case .HelveticaNeue: return "HelveticaNeue"
        case .HelveticaNeue_Light: return "HelveticaNeue-Light"
        case .HelveticaNeue_CondensedBold: return "HelveticaNeue-CondensedBold"
        case .HelveticaNeue_LightItalic: return "HelveticaNeue-LightItalic"
        case .HelveticaNeue_UltraLightItalic: return "HelveticaNeue-UltraLightItalic"
        case .HelveticaNeue_UltraLight: return "HelveticaNeue-UltraLight"
        case .HelveticaNeue_BoldItalic: return "HelveticaNeue-BoldItalic"
        case .HelveticaNeue_Italic: return "HelveticaNeue-Italic"
        }
    }
}
