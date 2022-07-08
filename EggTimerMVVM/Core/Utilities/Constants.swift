//
//  Constants.swift
//  EggTimerMVVM
//
//  Created by BERAT ALTUNTAŞ on 7.07.2022.
//

import Foundation
import UIKit

enum Images {
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
}

enum ImageSizes {
    static let width = 130
    static let height = 130
    static let imageViewSpaces = 45
}

enum ViewControllersConstants {
    static let eggDetailPageIdentifier = "EggDetailViewController"
    static let verticalSpaceSizeBetweenObjects: CGFloat = 58
}

enum EggAttiributes {
    static let eggImages: [UIImage] = [.egg1, .egg2, .egg3, .egg4]
    static let eggNames: [String] = ["Soft", "Medium", "Hard", "Over"]
    static let eggBoilMinutes: [Int] = [1, 7, 10, 12]
}
