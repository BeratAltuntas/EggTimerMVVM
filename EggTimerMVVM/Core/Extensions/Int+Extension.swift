//
//  Int+extension.swift
//  EggTimerMVVM
//
//  Created by BERAT ALTUNTAŞ on 8.07.2022.
//

import Foundation
import CoreGraphics

extension Int {
    static let totalSecondInOneMinute = 60
    
    func toCGFloat()-> CGFloat {
        return CGFloat(self)
    }
    
    func toFloat()-> Float {
        return Float(self)
    }
}
