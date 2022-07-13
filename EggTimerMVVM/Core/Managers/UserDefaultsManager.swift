//
//  UserDefaultsManager.swift
//  EggTimerMVVM
//
//  Created by BERAT ALTUNTAŞ on 7.07.2022.
//

import Foundation

// MARK: - UserDefaultsManager
final class UserDefaultsManager {
    enum UserDefaultsManagerConstants {
        static let keyForIsSet = "EggIsSet"
        static let keyForEggName = "EggName"
        static let keyForEggImageName = "EggImageName"
        static let keyForEggTotalMinute = "EggTotalMinute"
        static let keyForLastEnteredTime = "EggLastEnteredTime"
    }
    
    static let shared = UserDefaultsManager()
    private let ud = UserDefaults.standard
    
    func SetLastTickTime(egg: EggModel) {
        ud.set(true, forKey: UserDefaultsManagerConstants.keyForIsSet)
        ud.set(egg.eggImageName, forKey: UserDefaultsManagerConstants.keyForEggImageName)
        ud.set(egg.eggName, forKey: UserDefaultsManagerConstants.keyForEggName)
        ud.set(egg.eggBoilingMinute, forKey: UserDefaultsManagerConstants.keyForEggTotalMinute)
        ud.set(egg.eggLastEnteredTime, forKey: UserDefaultsManagerConstants.keyForLastEnteredTime)
    }
    
    func EggIsSet()->Bool {
        return ud.bool(forKey: UserDefaultsManagerConstants.keyForIsSet)
    }
    
    func GetLastEggName()-> String? {
        return ud.string(forKey: UserDefaultsManagerConstants.keyForEggName) ?? nil
    }
    
    func GetLastEggImageName()-> String? {
        return ud.string(forKey: UserDefaultsManagerConstants.keyForEggImageName)
    }
    
    func GetEggTotalMinute()-> Int? {
        return ud.integer(forKey: UserDefaultsManagerConstants.keyForEggTotalMinute)
    }
    
    func GetLastEnteredTime()-> String? {
        return ud.string(forKey: UserDefaultsManagerConstants.keyForLastEnteredTime)
    }
    
    func RemoveAllItems() {
        ud.removeObject(forKey: UserDefaultsManagerConstants.keyForEggImageName)
        ud.removeObject(forKey: UserDefaultsManagerConstants.keyForLastEnteredTime)
        ud.removeObject(forKey: UserDefaultsManagerConstants.keyForEggName)
        ud.removeObject(forKey: UserDefaultsManagerConstants.keyForIsSet)
    }
}
