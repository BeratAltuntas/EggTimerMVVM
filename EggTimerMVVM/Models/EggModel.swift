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
    var eggImageName: String
    var eggBoilingMinute: Int
    var eggBoilingTotalSecond: Int
    var eggBoilingSecond: Int
    var eggLastEnteredTime: String
    var eggIsSetBefore: Bool
    
    init() {
        eggName = ""
        eggImageName = ""
        eggBoilingTotalSecond = 0
        eggBoilingMinute = 0
        eggBoilingSecond = 0
        eggLastEnteredTime = ""
        eggIsSetBefore = false
    }
    
    init(eggName: String,
         eggImage: String,
         eggBoilingMinute: Int,
         eggBoilingTotalSecond: Int,
         eggBoilingSecond: Int,
         eggLastEnteredTime: String,
         eggIsSetBefore: Bool) {
        
        self.eggName = eggName
        self.eggImageName = eggImage
        self.eggBoilingMinute = eggBoilingMinute
        self.eggBoilingTotalSecond = eggBoilingTotalSecond
        self.eggBoilingSecond = eggBoilingSecond
        self.eggLastEnteredTime = eggLastEnteredTime
        self.eggIsSetBefore = eggIsSetBefore
    }
    
    
    
    
}




