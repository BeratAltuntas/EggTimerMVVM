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
    
    private var labelTitle: UILabel!
    private var imageviewsContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let VM = HomeViewModel()
        viewModel = VM
        viewModel.SetupUI()
    }
    
    private func SetupLabel() {
        labelTitle = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textAlignment = .center
        labelTitle.text = "How Do You Like Your Egg?"
        labelTitle.font = .Helvetica(size: 28)
        view.addSubview(labelTitle)
        
        NSLayoutConstraint.activate([
            // labelTitle
            labelTitle.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 78),
            labelTitle.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            labelTitle.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    private func SetupImageViewContainer() {
        imageviewsContainer = UIView()
        imageviewsContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageviewsContainer)
        
        NSLayoutConstraint.activate([
            // imageviewsView
            imageviewsContainer.topAnchor.constraint(equalTo: labelTitle.layoutMarginsGuide.bottomAnchor, constant: 78),
            imageviewsContainer.widthAnchor.constraint(equalToConstant: 305),
            imageviewsContainer.heightAnchor.constraint(equalToConstant: 305),
            imageviewsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        SetupImageViews()
    }
    
    private func SetupImageViews() {
        var index: Int = .zero
        let width = ImageSizes.width
        let height = ImageSizes.height
        let imageViewSpaces = ImageSizes.imageViewSpaces
        
        
        for row in 0..<2 {
            for col in 0..<2 {
                let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ImageTapped(tapGestureRecognizer:)))
                let imageview = UIImageView(image: ViewControllersConstants.images[index])
                imageview.isUserInteractionEnabled = true
                imageview.addGestureRecognizer(imageTapGestureRecognizer)
                imageview.layer.masksToBounds = true
                imageview.tag = index
                let frame = CGRect(x: col * width + (col * imageViewSpaces), y: row * height + (row * imageViewSpaces), width: width  , height: height)
                imageview.frame = frame
                imageview.layer.cornerRadius = imageview.frame.width/4.0
                imageviewsContainer.addSubview(imageview)
                index+=1
            }
        }
    }
    
    private func PushView(withImageTag: Int) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: ViewControllersConstants.eggDetailPageIdentifier) as! EggDetailViewController
        let eggViewModel = EggDetailViewModel()
        vc.viewModel = eggViewModel
        showHero(vc,navigationAnimationType: .zoom)
        
        //        guard let withImageTag = withImageTag else { return }
        //        let vc = storyboard?.instantiateViewController(withIdentifier: EggCountdownVCConstants.eggVCIndetifier) as! EggCountdownViewController
        //        if UserDefaultsManager.shared.GetEggIsSet(),
        //           let eggName = UserDefaultsManager.shared.GetLastEggName(),
        //           let eggImagename = UserDefaultsManager.shared.GetLastEggImageName(),
        //           let eggTime = UserDefaultsManager.shared.GetLastTickTime(),
        //           let leftMin = UserDefaultsManager.shared.GetLeftMinute(),
        //           let leftTotalSec = UserDefaultsManager.shared.GetLeftTotalSecond(),
        //           let leftSec = UserDefaultsManager.shared.GetLeftSecond() {
        //
        //            vc.egg.eggIsSetBefore = true
        //            vc.egg.eggImageName = eggImagename
        //            vc.egg.eggName = eggName
        //            vc.egg.eggBoilingTotalSecond = leftTotalSec
        //            vc.egg.eggBoilingSecond = leftSec
        //            vc.egg.eggBoilingMinute = leftMin
        //
        //            vc.lastTickedTime = eggTime
        //
        //        } else {
        //            vc.egg.eggName = ViewConstants.eggNames[withImageTag]
        //            vc.egg.eggImageName = ViewConstants.imageNames[withImageTag]
        //            vc.egg.eggBoilingMinute = ViewConstants.eggBoilingTimes[withImageTag]
        //            vc.egg.eggBoilingTotalSecond = ViewConstants.eggBoilingTimes[withImageTag] * 60
        //            vc.egg.eggBoilingSecond = 0
        //            vc.egg.eggIsSetBefore = false
        //        }
        //        navigationController?.pushViewController(vc,animated: true)
        //    }
    }
    
    @objc func ImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        switch tapGestureRecognizer.view?.tag {
        case 0:
            PushView(withImageTag: 0)
        case 1:
            PushView(withImageTag: 1)
        case 2:
            PushView(withImageTag: 2)
        case 3:
            PushView(withImageTag: 3)
        default:
            break
        }
    }
}

// MARK: - Extension: HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func LoadUI() {
        SetupLabel()
        SetupImageViewContainer()
    }
}
