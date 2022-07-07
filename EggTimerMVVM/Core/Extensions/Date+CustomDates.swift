//
//  Date+CustomDates.swift
//  EggTimerMVVM
//
//  Created by BERAT ALTUNTAŞ on 7.07.2022.
//

import Foundation

extension Date {
    var getCurrentYear: Int {
        return Calendar.current.component(.year, from: Date())
    }
    var getCurrentMonth: Int {
        return Calendar.current.component(.month, from: Date())
    }
    var getCurrentDay: Int {
        return Calendar.current.component(.day, from: Date())
    }
    var getCurrentHour: Int {
        return Calendar.current.component(.hour, from: Date())
    }
    var getCurrentMinute: Int {
        return Calendar.current.component(.minute, from: Date())
    }
    var getCurrentSecond: Int {
        return Calendar.current.component(.second, from: Date())
    }
}
