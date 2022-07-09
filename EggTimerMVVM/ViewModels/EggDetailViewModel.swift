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
    func LoadTimerAttiributes()
}

// MARK: - EggDetailViewModelDelegate
protocol EggDetailViewModelDelegate: AnyObject {
    var selectedEggVM: EggModel! { get }
    
    func LoadUI()
    func UpdateCountdownLabel()
    func UpdateSliderBar()
    func ShowAlertView()
    func Stop_TUI()
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
            delegate?.Stop_TUI()
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
}
