//
//  UIImage+CustomImages.swift
//  EggTimerMVVM
//
//  Created by BERAT ALTUNTAŞ on 7.07.2022.
//

import Foundation
import UIKit

extension UIImage {
    // EGG Images
    static var egg1: UIImage {
        return UIImage(named: "egg-1")!
    }
    static var egg2: UIImage {
        return UIImage(named: "egg-2")!
    }
    static var egg3: UIImage {
        return UIImage(named: "egg-3")!
    }
    static var egg4: UIImage {
        return UIImage(named: "egg-4")!
    }
    
    // Button System Images
    static var pause: UIImage {
        return UIImage(systemName: "pause.fill")!
    }
    static var play: UIImage {
        return UIImage(systemName: "play.fill")!
    }
    static var stop: UIImage {
        return UIImage(systemName: "stop.fill")!
    }
}
