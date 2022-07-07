//
//  HomeViewController.swift
//  EggTimerMVVM
//
//  Created by BERAT ALTUNTAŞ on 7.07.2022.
//

import UIKit

// MARK: - HomeViewController
final class HomeViewController: UIViewController {
    
    weak var viewModel: HomeViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

// MARK: - Extension: HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    
}
