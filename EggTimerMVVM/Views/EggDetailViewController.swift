//
//  EggDetailViewController.swift
//  EggTimerMVVM
//
//  Created by BERAT ALTUNTAŞ on 7.07.2022.
//

import UIKit

// MARK: - EggDetailViewController
final class EggDetailViewController: UIViewController {
    
    weak var viewModel: EggDetailViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Extension: EggDetailViewModelDelegate
extension EggDetailViewController: EggDetailViewModelDelegate {
    
}
