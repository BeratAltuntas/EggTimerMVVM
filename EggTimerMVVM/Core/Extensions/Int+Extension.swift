//
//  Int+extension.swift
//  EggTimerMVVM
//
//  Created by BERAT ALTUNTAŞ on 8.07.2022.
//

import Foundation
import CoreGraphics

extension Int {
    static let secondInOneMinute = 60
    
    func toDouble()-> Double {
        return Double(self)
    }
    
    func toCGFloat()-> CGFloat {
        return CGFloat(self)
    }
    
    func toFloat()-> Float {
        return Float(self)
    }
}
