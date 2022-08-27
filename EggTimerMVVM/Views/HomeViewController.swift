//
//  HomeViewController.swift
//  EggTimerMVVM
//
//  Created by BERAT ALTUNTAŞ on 7.07.2022.
//

import UIKit

// MARK: - HomeViewController
final class HomeViewController: UIViewController {
    var viewModel: HomeViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    private var labelTitle: UILabel!
    private var imageviewsContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        viewModel.SetupScreen()
        GetPermissionToSendNotification()
        if UserDefaultsManager.shared.EggIsSet(),
           let imageTag = UserDefaultsManager.shared.GetLastEggImageTagNumber() {
            PushView(withImageTag: imageTag)
        }
    }
    
    private func GetPermissionToSendNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.criticalAlert,.alert,.badge,.sound]) { [weak self] granted, error in
            if !granted {
                let ac = UIAlertController(title: "Notification Error.", message: "If you are not allow to application notifications you will never get notified.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] action in
                    self?.GetPermissionToSendNotification()
                }))
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                self?.present(ac, animated: true)
            }
        }
    }
    
    private func SetupRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks , target: self, action: #selector(HowToBoilEggInfo))
        navigationItem.rightBarButtonItem?.tintColor = .eggButtonColor
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
                let imageview = UIImageView(image: UIImage(named: EggAttiributes.eggImageNames[index]))
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
        if let vc = storyboard?.instantiateViewController(withIdentifier: ViewControllersConstants.eggDetailPageIdentifier) as? EggDetailViewController {
            vc.viewModel = EggDetailViewModel()
            
            var tempEgg = EggModel()
            tempEgg.eggName = EggAttiributes.eggNames[withImageTag]
            tempEgg.eggImageName = EggAttiributes.eggImageNames[withImageTag]
            tempEgg.eggBoilingMinute = EggAttiributes.eggBoilMinutes[withImageTag]
            tempEgg.eggBoilingTotalSecond = EggAttiributes.eggBoilMinutes[withImageTag] * .secondInOneMinute
            tempEgg.eggBoilingRemainingSecond = .zero
            tempEgg.eggImageTag = withImageTag
            if UserDefaultsManager.shared.EggIsSet(),
               let eggName = UserDefaultsManager.shared.GetLastEggName(),
               let eggImageName = UserDefaultsManager.shared.GetLastEggImageName(),
               let totalSec = UserDefaultsManager.shared.GetEggTotalSecond(),
               let remainingSec = UserDefaultsManager.shared.GetEggTotalRemainingSecond(),
               let imageTag = UserDefaultsManager.shared.GetLastEggImageTagNumber(),
               let lastEnteredTime = UserDefaultsManager.shared.GetLastEnteredTime() {
                
                let totalmin = totalSec % 60
                
                tempEgg.eggName = eggName
                tempEgg.eggImageName = eggImageName
                tempEgg.eggBoilingMinute = totalmin
                tempEgg.eggBoilingTotalSecond = totalSec
                tempEgg.eggBoilingTotalRemainingSecond = remainingSec
                tempEgg.eggLastEnteredTime = lastEnteredTime
                tempEgg.eggImageTag = imageTag
                tempEgg.eggIsSetBefore = true
            }
            
            vc.selectedEgg = tempEgg
            showHero(vc,navigationAnimationType: .zoomOut)
        }
    }
    
    @objc private func ImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
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
    
    @objc private func HowToBoilEggInfo() {
        let ac = UIAlertController(title: "How To Boil An Egg", message: "Place eggs in a medium pot and cover with cold water by 1 inch. Bring to a boil, then cover the pot and turn the heat off. Let the eggs cook, covered, for 6 to 12 minutes, depending on your desired done-ness (see photo).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
}

// MARK: - Extension: HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func LoadUI() {
        SetupRightBarButton()
        SetupLabel()
        SetupImageViewContainer()
    }
}
