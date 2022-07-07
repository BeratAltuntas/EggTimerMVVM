//
//  EggModel.swift
//  EggTimerMVVM
//
//  Created by BERAT ALTUNTAŞ on 7.07.2022.
//

import Foundation

struct EggModel {
    var eggName: String
    var eggImageName: String
    var eggBoilingMinute: Int
    var eggBoilingTotalSecond: Int
    var eggBoilingSecond: Int
    var eggIsSetBefore: Bool
    
    init() {
        eggName = ""
        eggImageName = ""
        eggBoilingTotalSecond = 0
        eggBoilingMinute = 0
        eggBoilingSecond = 0
        eggIsSetBefore = false
    }
    
    init(eggName: String,
         eggImageName:String,
         eggBoilingMinute: Int,
         eggBoilingTotalSecond: Int,
         eggBoilingSecond: Int,
         eggIsSetBefore: Bool) {
        
        self.eggName = eggName
        self.eggImageName = eggImageName
        self.eggBoilingMinute = eggBoilingMinute
        self.eggBoilingTotalSecond = eggBoilingTotalSecond
        self.eggBoilingSecond = eggBoilingSecond
        self.eggIsSetBefore = eggIsSetBefore
    }
    
    
    
    
}




