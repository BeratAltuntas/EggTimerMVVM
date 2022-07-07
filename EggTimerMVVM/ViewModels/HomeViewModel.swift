//
//  HomeViewModel.swift
//  EggTimerMVVM
//
//  Created by BERAT ALTUNTAŞ on 7.07.2022.
//

import Foundation

// MARK: - HomeViewModelProtocol
protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    func SetupUI()
}

// MARK: - HomeViewModelDelegate
protocol HomeViewModelDelegate: AnyObject {
    func LoadUI()
}

// MARK: - HomeViewModel
final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
}

// MARK: - Extension: HomeViewModelProtocol
extension HomeViewModel: HomeViewModelProtocol {
    func SetupUI() {
        delegate?.LoadUI()
    }
}
