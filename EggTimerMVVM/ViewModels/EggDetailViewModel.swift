//
//  EggDetailViewModel.swift
//  EggTimerMVVM
//
//  Created by BERAT ALTUNTAŞ on 7.07.2022.
//

import Foundation

// MARK: - EggDetailViewModelProtocol
protocol EggDetailViewModelProtocol {
    var delegate: EggDetailViewModelDelegate! { get set }
    var timer: Timer! { get set }
    var countdownEggBoilingTotalSecond: Int { get }
    var countdownTimerSecond: Int { get }
    var countdownTimerMinute: Int { get }
    
    func SetupScreen()
    func StartTimer()
    func StopTimer()
    func LoadTimerAttiributes()
    func CalculateTime()
    func ApplicationDidEnterBackground()
    func ApplicationComesBackFromBackground()
}

// MARK: - EggDetailViewModelDelegate
protocol EggDetailViewModelDelegate: AnyObject {
    var selectedEggVM: EggModel! { get set }
    
    func LoadUI()
    func UpdateCountdownLabel()
    func UpdateSliderBar()
    func ShowAlertView()
    func PlayButton()
    func StopButton()
}

// MARK: - EggDetailViewModel
final class EggDetailViewModel {
    weak var delegate: EggDetailViewModelDelegate!
    var timer: Timer!
    
    var countdownTimerSecond: Int = .zero
    var countdownTimerMinute: Int = .zero
    var countdownEggBoilingTotalSecond: Int = .zero
    
    @objc private func TimerTick() {
        countdownEggBoilingTotalSecond -= 1
        countdownTimerSecond -= 1
        
        if countdownTimerSecond <= 0 {
            countdownTimerSecond = .secondInOneMinute - 1
            countdownTimerMinute -= 1
        }
        
        if countdownTimerSecond <= 0 || countdownTimerMinute < 0 || countdownEggBoilingTotalSecond <= 0 {
            SoundPlayerManager.shared.playSound(withSoundName: .alarm)
            delegate?.StopButton()
            delegate?.ShowAlertView()
        }
        delegate?.UpdateSliderBar()
        delegate?.UpdateCountdownLabel()
    }
}

// MARK: - Extension: EggDetailViewModelProtocol
extension EggDetailViewModel: EggDetailViewModelProtocol {
    func SetupScreen() {
        delegate?.LoadUI()
    }
    
    func StartTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.toDouble(), target: self, selector: #selector(TimerTick), userInfo: nil, repeats: true)
    }
    
    func StopTimer() {
        guard timer != nil else { return }
        self.timer.invalidate()
        self.timer = nil
    }
    
    func LoadTimerAttiributes() {
        countdownEggBoilingTotalSecond = (delegate?.selectedEggVM.eggBoilingTotalSecond)!
        countdownTimerSecond = (delegate?.selectedEggVM.eggBoilingRemainingSecond)!
        countdownTimerMinute = (delegate?.selectedEggVM.eggBoilingMinute)!
    }
    
    func ApplicationDidEnterBackground() {
        if timer != nil {
            UserDefaultsManager.shared.RemoveAllItems()
            let time = "\(Date.now.getCurrentSecond).\(Date.now.getCurrentMinute).\(Date.now.getCurrentHour)"
            
            let eggModel = EggModel(eggName: (delegate?.selectedEggVM.eggName)!,
                                    eggImage: (delegate?.selectedEggVM.eggImageName)!,
                                    eggBoilingMinute: countdownTimerMinute,
                                    eggBoilingTotalSecond: delegate.selectedEggVM.eggBoilingTotalSecond,
                                    eggBoilingRemainingSecond: countdownTimerSecond,
                                    eggBoilingTotalRemainingSecond: countdownEggBoilingTotalSecond,
                                    eggLastEnteredTime: time,
                                    eggIsSetBefore: true,
                                    eggImageTag: (delegate?.selectedEggVM.eggImageTag)!)
            
            UserDefaultsManager.shared.SetLastTickTime(egg: eggModel)
            timer.invalidate()
            timer = nil
        }
    }
    
    func ApplicationComesBackFromBackground() {
        if UserDefaultsManager.shared.EggIsSet(),
           let eggName = UserDefaultsManager.shared.GetLastEggName(),
           let eggImageName = UserDefaultsManager.shared.GetLastEggImageName(),
           let totalSec = UserDefaultsManager.shared.GetEggTotalSecond(),
           let remainingSec = UserDefaultsManager.shared.GetEggTotalRemainingSecond(),
           let lastEnteredTime = UserDefaultsManager.shared.GetLastEnteredTime() {
            
            let totalMin = totalSec % 60
            
            var tempEgg = EggModel()
            tempEgg.eggName = eggName
            tempEgg.eggImageName = eggImageName
            tempEgg.eggBoilingMinute = totalMin
            tempEgg.eggLastEnteredTime = lastEnteredTime
            tempEgg.eggBoilingTotalSecond = totalSec
            tempEgg.eggBoilingTotalRemainingSecond = remainingSec
            tempEgg.eggIsSetBefore = true
            delegate?.selectedEggVM = tempEgg
        }
    }
    
    func CalculateTime() {
        guard let t = UserDefaultsManager.shared.GetLastEnteredTime() else { return }
        guard let USDremainingEggSec = UserDefaultsManager.shared.GetEggTotalRemainingSecond() else { return }
        guard let USDEggTotalSec = UserDefaultsManager.shared.GetEggTotalSecond() else { return }
        
        let times = t.split(separator: ".")
        
        let sec = times[0]
        let min = times[1]
        
        var difMinute = Date.now.getCurrentMinute < Int(min)! ? 60 - Int(min)! + Date.now.getCurrentMinute : Date.now.getCurrentMinute - Int(min)!
        
        var difSecond = 0
        if Date.now.getCurrentSecond < Int(sec)! {
            difSecond = (60 - Int(sec)!) + Date.now.getCurrentSecond
            difMinute += 1
        } else {
            difSecond = (Date.now.getCurrentSecond - Int(sec)!)
        }
        
        let tempTotalSecond = USDremainingEggSec - difSecond - (60 * difMinute)
        if (difMinute * 60 < USDEggTotalSec || difSecond != .zero ) && tempTotalSecond > 0 {
            
            delegate?.selectedEggVM.eggBoilingTotalRemainingSecond = tempTotalSecond
            delegate?.selectedEggVM.eggBoilingMinute =  (tempTotalSecond - (tempTotalSecond % 60)) / 60
            delegate?.selectedEggVM.eggBoilingRemainingSecond = (tempTotalSecond % 60)
            LoadTimerAttiributes()
            delegate?.PlayButton()
        } else {
            UserDefaultsManager.shared.RemoveAllItems()
            SoundPlayerManager.shared.playAlarmSound()
            delegate?.ShowAlertView()
            delegate?.StopButton()
        }
    }
}

