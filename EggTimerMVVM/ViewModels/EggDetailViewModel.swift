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
    var timer: Timer! { get }
    var countdownEggBoilingTotalSecond: Int { get }
    var countdownTimerSecond: Int { get }
    var countdownTimerMinute: Int { get }
    
    func SetupScreen()
    func StartTimer()
    func StopTimer()
    func LoadTimerAttiributes()
    func ApplicationResign()
    func CalculateTime()
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
        timer.invalidate()
    }
    
    func LoadTimerAttiributes() {
        countdownEggBoilingTotalSecond = (delegate?.selectedEggVM.eggBoilingTotalSecond)!
        countdownTimerSecond = (delegate?.selectedEggVM.eggBoilingSecond)!
        countdownTimerMinute = (delegate?.selectedEggVM.eggBoilingMinute)!
    }
    
    func ApplicationResign() {
        if timer != nil {
            let time = "\(Date.now.getCurrentSecond).\(Date.now.getCurrentMinute).\(Date.now.getCurrentHour)"
            let eggModel = EggModel(eggName: (delegate?.selectedEggVM.eggName)!,
                                    eggImage: (delegate?.selectedEggVM.eggImageName)!,
                                    eggBoilingMinute: countdownTimerMinute,
                                    eggBoilingTotalSecond: countdownEggBoilingTotalSecond,
                                    eggBoilingSecond: countdownTimerSecond,
                                    eggLastEnteredTime: time,
                                    eggIsSetBefore: true)
            UserDefaultsManager.shared.SetLastTickTime(egg: eggModel)
        }
    }
    
    func CalculateTime() {
        guard let t = UserDefaultsManager.shared.GetLastEnteredTime() else { return }
        guard let selectedEgg = delegate?.selectedEggVM else { return }
        let times = t.split(separator: ".")
        
        let sec = times[0]
        let min = times[1]
        let hour = times[2]
        
        let difHour = Date.now.getCurrentHour - Int(hour)!
        let difMinute = Date.now.getCurrentMinute - Int(min)!
        let difSecond = Date.now.getCurrentSecond - Int(sec)!
        
        if difHour == 0 {
            if difMinute < selectedEgg.eggBoilingMinute && difSecond == .zero {
                delegate?.selectedEggVM.eggBoilingTotalSecond = (selectedEgg.eggBoilingMinute - difMinute) * 60
                delegate?.selectedEggVM.eggBoilingMinute = selectedEgg.eggBoilingMinute - difMinute
                if difSecond > 0 {
                    delegate?.selectedEggVM.eggBoilingSecond = 60 - difSecond
                } else if difSecond < 0 {
                    delegate?.selectedEggVM.eggBoilingMinute -= 1
                    delegate?.selectedEggVM.eggBoilingSecond = difSecond
                } else {
                    delegate?.selectedEggVM.eggBoilingSecond = Int(sec)!
                }
                delegate?.PlayButton()
            } else if difHour >= selectedEgg.eggBoilingMinute {
                UserDefaultsManager.shared.RemoveAllItems()
                delegate?.ShowAlertView()
            }
        } else {
            UserDefaultsManager.shared.RemoveAllItems()
            delegate?.ShowAlertView()
        }
        
    }
}
