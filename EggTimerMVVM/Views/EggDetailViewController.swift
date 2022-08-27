//
//  EggDetailViewController.swift
//  EggTimerMVVM
//
//  Created by BERAT ALTUNTAŞ on 7.07.2022.
//

import UIKit

// MARK: - EggDetailViewController
final class EggDetailViewController: UIViewController {
    var viewModel: EggDetailViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    // UI Elements
    private var labelEggTitle: UILabel!
    private var labelCountdown: UILabel!
    private var imageView: UIImageView!
    private var sliderCountdown: UISlider!
    private var viewButtonContainer: UIView!
    private var playButton: UIButton!
    private var pauseButton: UIButton!
    private var stopButton: UIButton!
    
    // Egg CountDown Timer Variables
    private var labelColonsShow: Bool = true
    
    var selectedEgg: EggModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.SetupScreen()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isBeingDismissed || self.isMovingFromParent{
            UserDefaultsManager.shared.RemoveAllItems()
        }
        Stop_TUI()
    }
    
    private func SetupEggTitleLabel() {
        labelEggTitle = UILabel()
        labelEggTitle.textColor = .black
        labelEggTitle.text = selectedEgg.eggName + " Boiled"
        labelEggTitle.font = .HelveticaNeue(size: 42)
        labelEggTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelEggTitle)
        
        NSLayoutConstraint.activate([
            labelEggTitle.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: ViewControllersConstants.verticalSpaceSizeBetweenObjects),
            labelEggTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func SetupImageView() {
        imageView = UIImageView(image: UIImage(named: selectedEgg.eggImageName))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width/4.0
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: labelEggTitle.layoutMarginsGuide.bottomAnchor, constant: ViewControllersConstants.verticalSpaceSizeBetweenObjects),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: ImageSizes.width.toCGFloat()),
            imageView.heightAnchor.constraint(equalToConstant: ImageSizes.height.toCGFloat())
        ])
    }
    
    private func SetupSliderBar() {
        sliderCountdown = UISlider()
        sliderCountdown.tintColor = .eggButtonColor
        sliderCountdown.maximumValue = selectedEgg.eggBoilingTotalSecond.toFloat()
        sliderCountdown.minimumValue = .zero
        sliderCountdown.value = Float(selectedEgg.eggBoilingTotalSecond)
        sliderCountdown.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sliderCountdown)
        
        NSLayoutConstraint.activate([
            sliderCountdown.topAnchor.constraint(equalTo: labelCountdown.layoutMarginsGuide.bottomAnchor, constant: ViewControllersConstants.verticalSpaceSizeBetweenObjects),
            sliderCountdown.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sliderCountdown.widthAnchor.constraint(equalToConstant: view.frame.width/1.2),
            sliderCountdown.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func SetupCountdownLabel() {
        labelCountdown = UILabel()
        labelCountdown.textColor = .black
        labelCountdown.font = .HelveticaNeue(size: 50)
        labelCountdown.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelCountdown)
        
        NSLayoutConstraint.activate([
            labelCountdown.topAnchor.constraint(equalTo: imageView.layoutMarginsGuide.bottomAnchor, constant: ViewControllersConstants.verticalSpaceSizeBetweenObjects),
            labelCountdown.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func SetupButtons() {
        viewButtonContainer = UIView()
        viewButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewButtonContainer)
        
        NSLayoutConstraint.activate([
            viewButtonContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewButtonContainer.topAnchor.constraint(equalTo: sliderCountdown.bottomAnchor, constant: ViewControllersConstants.verticalSpaceSizeBetweenObjects),
            viewButtonContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            viewButtonContainer.heightAnchor.constraint(equalToConstant: 100)
        ])
        var lastButton: UIButton?
        for i in 0..<3 {
            let button = UIButton(type: .system)
            button.tintColor = .black
            button.backgroundColor = .eggButtonColor
            switch i {
            case 0:
                button.setImage(.stop, for: .normal)
            case 1:
                button.setImage(.play, for: .normal)
            case 2:
                button.setImage(.pause, for: .normal)
            default:
                break
            }
            button.layer.cornerRadius = 25.0
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.brown.cgColor
            button.translatesAutoresizingMaskIntoConstraints = false
            switch i {
            case 0:
                button.addTarget(self, action: #selector(Stop_TUI), for: .touchUpInside)
                button.isHidden = true
                stopButton = button
                
            case 1:
                button.addTarget(self, action: #selector(Play_TUI), for: .touchUpInside)
                button.isHidden = false
                playButton = button
                
            case 2:
                button.addTarget(self, action: #selector(Pause_TUI), for: .touchUpInside)
                button.isHidden = true
                pauseButton = button
                
            default:
                break
            }
            viewButtonContainer.addSubview(button)
            
            if let last = lastButton {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: viewButtonContainer.topAnchor, constant: CGFloat(((i % 2 == 0) ? 2: 1) * 10)),
                    button.leadingAnchor.constraint(equalTo: last.trailingAnchor, constant: 40),
                    button.widthAnchor.constraint(equalToConstant: CGFloat(70 + ((i%2) * 10))),
                    button.heightAnchor.constraint(equalToConstant: CGFloat( 70 + ((i%2) * 10)))
                ])
            } else {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: viewButtonContainer.topAnchor, constant: CGFloat(((i % 2 == 0) ? 2: 1) * 10)),
                    button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.width - 300)/2),
                    button.widthAnchor.constraint(equalToConstant: CGFloat(70 + ((i%2) * 10))),
                    button.heightAnchor.constraint(equalToConstant: CGFloat( 70 + ((i%2) * 10)))
                ])
            }
            lastButton = button
        }
        lastButton = nil
    }
    
    private func LoadTimerAttiributes() {
        viewModel.LoadTimerAttiributes()
    }
    
    private func SetupTimer() {
        StartTimer()
    }
    
    private func StartTimer() {
        viewModel.StartTimer()
    }
    
    private func StopTimer() {
        labelColonsShow = true
        viewModel.StopTimer()
    }
    
    @objc private func Pause_TUI() {
        StopTimer()
        playButton.isEnabled = true
        pauseButton.isEnabled = false
        stopButton.isEnabled = true
    }
    
    @objc private func Play_TUI() {
        LoadTimerAttiributes()
        if viewModel.timer == nil {
            SetupTimer()
        } else {
            StartTimer()
        }
        playButton.isEnabled = false
        pauseButton.isEnabled = true
        pauseButton.isHidden = false
        stopButton.isHidden = false
        stopButton.isEnabled = true
        CreatePushAlert()
    }
    
    @objc func Stop_TUI() {
        selectedEggVM.eggBoilingMinute = selectedEgg.eggBoilingTotalSecond / .secondInOneMinute
        selectedEggVM.eggBoilingRemainingSecond = 0
        StopTimer()
        DestroyPushAlerts()
        LoadTimerAttiributes()
        UpdateSliderBar()
        UpdateCountdownLabel()
        
        viewModel.timer = nil
        playButton.isEnabled = true
        playButton.isHidden = false
        pauseButton.isHidden = true
        stopButton.isHidden = true
    }
    
    @objc private func ApplicationDidEnterBackground() {
        viewModel.ApplicationDidEnterBackground()
        viewModel.StopTimer()
    }
    
    @objc private func ApplicationComesBackFromBackground() {
        viewModel.ApplicationComesBackFromBackground()
        viewModel.CalculateTime()
    }
}

// MARK: - Extension: EggDetailViewModelDelegate
extension EggDetailViewController: EggDetailViewModelDelegate {
    
    var selectedEggVM: EggModel! {
        get {
            return self.selectedEgg
        }
        
        set {
            self.selectedEgg = newValue
        }
    }
    
    func LoadUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(ApplicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ApplicationComesBackFromBackground), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        
        view.backgroundColor = .white
        SetupEggTitleLabel()
        SetupImageView()
        SetupCountdownLabel()
        SetupSliderBar()
        SetupButtons()
        if selectedEgg.eggIsSetBefore {
            viewModel.CalculateTime()
        }
        LoadTimerAttiributes()
        UpdateCountdownLabel()
        UpdateSliderBar()
    }
    
    func UpdateSliderBar() {
        DispatchQueue.main.async { [weak self] in
            self?.sliderCountdown.value = self!.viewModel.countdownEggBoilingTotalSecond.toFloat()
        }
    }
    
    func UpdateCountdownLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let timerMin = self?.viewModel.countdownTimerMinute else { return }
            guard let timerSec = self?.viewModel.countdownTimerSecond else { return }
            var minString: String
            var secString: String
            
            if timerMin / 10 > 0 {
                minString = "\(timerMin)"
            } else {
                minString = "0\(timerMin)"
            }
            
            if timerSec / 10 > 0 {
                secString = "\(timerSec)"
            } else {
                secString = "0\(timerSec)"
            }
            
            if self!.labelColonsShow {
                self?.labelCountdown.text = "\(minString) : \(secString)"
                self?.labelColonsShow = false
            } else {
                self?.labelCountdown.text = "\(minString)   \(secString)"
                self?.labelColonsShow = true
            }
        }
    }
    
    func ShowAlertView() {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Egg Is Boiled", message: "The egg is boiled. Take from the stove.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] action in
                self?.hero.dismissViewController()
            }))
            self.present(ac, animated: true)
        }
    }
    
    func PlayButton() {
        Play_TUI()
    }
    
    func StopButton() {
        Stop_TUI()
    }
}

extension EggDetailViewController: UNUserNotificationCenterDelegate {
    private func GetPermissionToSendNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.criticalAlert,.alert,.badge,.sound]) { granted, error in
        }
    }
    
    private func CreatePushAlertCategories(){
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let remindMeLater = UNNotificationAction(identifier: "remindeMeLater", title: "Remind Me Later", options: .foreground)
        let category = UNNotificationCategory(identifier: "boiled", actions: [show,remindMeLater], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    private func CreatePushAlert() {
        CreatePushAlertCategories()
        let center = UNUserNotificationCenter.current()
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Egg Is Boiled."
        notificationContent.body = "The egg is boiled. Take from the stove."
        notificationContent.categoryIdentifier = "boiled"
        notificationContent.sound = .default
        
        let whenIsTriggering = UNTimeIntervalNotificationTrigger(timeInterval: selectedEgg.eggBoilingTotalSecond.toDouble(), repeats: false)
        let notification = UNNotificationRequest(identifier: ViewControllersConstants.eggPushNotificationIdentifier, content: notificationContent, trigger: whenIsTriggering)
        center.add(notification)
        
    }
    
    private func DestroyPushAlerts() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
