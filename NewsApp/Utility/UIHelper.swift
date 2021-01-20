//
//  UIHelper.swift
//  NewsApp
//
//  Created by DIAKO on 1/19/21.
//

import Foundation
import UIKit

class UIHelper {
    
    static func SFProRoundedBlack(size: CGFloat) -> UIFont {
        return R.font.sfProRoundedBlack(size: size)!
    }
    
    static func SFProRoundedBold(size: CGFloat) -> UIFont {
        return R.font.sfProRoundedBold(size: size)!
    }
    
    static func SFProRoundedHeavy(size: CGFloat) -> UIFont {
        return R.font.sfProRoundedHeavy(size: size)!
    }
    
    static func SFProRoundedLight(size: CGFloat) -> UIFont {
        return R.font.sfProRoundedLight(size: size)!
    }
    
    static func SFProRoundedMedium(size: CGFloat) -> UIFont {
        return R.font.sfProRoundedMedium(size: size)!
    }
    
    static func SFProRoundedBRegular(size: CGFloat) -> UIFont {
        return R.font.sfProRoundedRegular(size: size)!
    }
    
    static func SFProRoundedSemibold(size: CGFloat) -> UIFont {
        return R.font.sfProRoundedSemibold(size: size)!
    }
    
    static func SFProRoundedThin(size: CGFloat) -> UIFont {
        return R.font.sfProRoundedThin(size: size)!
    }
    
    static func SFProRoundedUltralight(size: CGFloat) -> UIFont {
        return R.font.sfProRoundedUltralight(size: size)!
    }
    
    static func notificationVibrateFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}
