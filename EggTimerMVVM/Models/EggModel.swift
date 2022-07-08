//
//  EggModel.swift
//  EggTimerMVVM
//
//  Created by BERAT ALTUNTAŞ on 7.07.2022.
//

import Foundation
import UIKit

// MARK: - EggModel
struct EggModel {
    var eggName: String
    var eggImage: UIImage
    var eggBoilingMinute: Int
    var eggBoilingTotalSecond: Int
    var eggBoilingSecond: Int
    var eggIsSetBefore: Bool
    
    init() {
        eggName = ""
        eggImage = UIImage()
        eggBoilingTotalSecond = 0
        eggBoilingMinute = 0
        eggBoilingSecond = 0
        eggIsSetBefore = false
    }
    
    init(eggName: String,
         eggImage: UIImage,
         eggBoilingMinute: Int,
         eggBoilingTotalSecond: Int,
         eggBoilingSecond: Int,
         eggIsSetBefore: Bool) {
        
        self.eggName = eggName
        self.eggImage = eggImage
        self.eggBoilingMinute = eggBoilingMinute
        self.eggBoilingTotalSecond = eggBoilingTotalSecond
        self.eggBoilingSecond = eggBoilingSecond
        self.eggIsSetBefore = eggIsSetBefore
    }
    
    
    
    
}




