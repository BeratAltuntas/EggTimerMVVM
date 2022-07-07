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
}

// MARK: - EggDetailViewModelDelegate
protocol EggDetailViewModelDelegate: AnyObject {
    
}

// MARK: - EggDetailViewModel
final class EggDetailViewModel {
    weak var delegate: EggDetailViewModelDelegate!
}

// MARK: - Extension: EggDetailViewModelProtocol
extension EggDetailViewModel: EggDetailViewModelProtocol {
    
}
