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
        static let keyForEggImageTagNumber = "EggImageTagNumber"
        static let keyForEggTotalSecond = "EggTotalSecond"
        static let keyForEggTotalRemainingSecond = "EggTotalRemainingSecond"
        static let keyForLastEnteredTime = "EggLastEnteredTime"
    }
    
    static let shared = UserDefaultsManager()
    private let ud = UserDefaults.standard
    
    func SetLastTickTime(egg: EggModel) {
        print(egg.eggBoilingTotalSecond)
        print(egg.eggBoilingTotalRemainingSecond)
        
        ud.set(true, forKey: UserDefaultsManagerConstants.keyForIsSet)
        ud.set(egg.eggImageName, forKey: UserDefaultsManagerConstants.keyForEggImageName)
        ud.set(egg.eggName, forKey: UserDefaultsManagerConstants.keyForEggName)
        ud.set(egg.eggBoilingTotalSecond, forKey: UserDefaultsManagerConstants.keyForEggTotalSecond)
        ud.set(egg.eggBoilingTotalRemainingSecond, forKey: UserDefaultsManagerConstants.keyForEggTotalRemainingSecond)
        ud.set(egg.eggLastEnteredTime, forKey: UserDefaultsManagerConstants.keyForLastEnteredTime)
        ud.set(egg.eggImageTag, forKey: UserDefaultsManagerConstants.keyForEggImageTagNumber)
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
    
    func GetLastEggImageTagNumber()-> Int? {
        return ud.integer(forKey: UserDefaultsManagerConstants.keyForEggImageTagNumber)
    }
    
    func GetEggTotalSecond()-> Int? {
        return ud.integer(forKey: UserDefaultsManagerConstants.keyForEggTotalSecond)
    }
    
    func GetEggTotalRemainingSecond()-> Int? {
        return ud.integer(forKey: UserDefaultsManagerConstants.keyForEggTotalRemainingSecond)
    }
    
    func GetLastEnteredTime()-> String? {
        return ud.string(forKey: UserDefaultsManagerConstants.keyForLastEnteredTime)
    }
    
    func RemoveAllItems() {
        ud.removeObject(forKey: UserDefaultsManagerConstants.keyForEggImageName)
        ud.removeObject(forKey: UserDefaultsManagerConstants.keyForEggTotalRemainingSecond)
        ud.removeObject(forKey: UserDefaultsManagerConstants.keyForEggTotalSecond)
        ud.removeObject(forKey: UserDefaultsManagerConstants.keyForLastEnteredTime)
        ud.removeObject(forKey: UserDefaultsManagerConstants.keyForEggName)
        ud.removeObject(forKey: UserDefaultsManagerConstants.keyForIsSet)
        ud.removeObject(forKey: UserDefaultsManagerConstants.keyForEggImageTagNumber)
    }
}
