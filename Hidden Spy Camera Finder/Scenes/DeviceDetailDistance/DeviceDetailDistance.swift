//
//  DeviceDetailDistance.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 13.11.2023.
//

import UIKit
import TinyConstraints
import Lottie
import SwiftUI

class DeviceDistanceViewController: HSCFBaseViewController {
    // MARK: - UIProperties
    private lazy var radarView: UIView = {
        let v = UIView()
        v.aspectRatio(1)
        v.backgroundColor = .clear
        return v
    }()
    
    private lazy var distanceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.gilroy(.medium, size: isiPad ? 30 : 18)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.customLightBlue
        lbl.text = "Distance: 10 m"
        return lbl
    }()
    
    private lazy var alertLabel: UIView = {
        let lbl = UILabel()
        lbl.font = UIFont.gilroy(.medium, size: isiPad ? 26 : 16)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.customDarkBlue
        lbl.text = "Move to strengthen the signal"
        return lbl
    }()
    
    // MARK: - Properties
    public var name: String?
    public var rssi: Int? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.distanceLabel.text = "Distance: \(self?.rssi ?? 0) m"
            }
        }
    }
    
    lazy var bluService = BLUService()
    private var animationView: LottieAnimationView!
    
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSubviews()
        if let name {
            self.title = name
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        animateRadar()
    }
    
    private func prepareSubviews() {
        view.addSubview(radarView)
        if isiPad {
            radarView.topToSuperview(offset: 26, usingSafeArea: true)
            radarView.centerXToSuperview()
            radarView.width(660)
        } else {
            radarView.topToSuperview(usingSafeArea: true)
            radarView.leftToSuperview(offset: -40)
            radarView.rightToSuperview(offset: 40)
        }

        view.addSubview(distanceLabel)
        if isiPad {
            distanceLabel.topToBottom(of: radarView)
            distanceLabel.centerXToSuperview()
            distanceLabel.width(560)
        } else {
            distanceLabel.topToBottom(of: radarView, offset: -16)
            distanceLabel.leadingToSuperview(offset: 20)
            distanceLabel.trailingToSuperview(offset: 20)
        }

        view.addSubview(alertLabel)
        if isiPad {
            alertLabel.topToBottom(of: distanceLabel, offset: 13)
            alertLabel.centerXToSuperview()
            alertLabel.width(560)
        } else {
            alertLabel.topToBottom(of: distanceLabel, offset: 8)
            alertLabel.leadingToSuperview(offset: 20)
            alertLabel.trailingToSuperview(offset: 20)
        }
    }
    
    private func animateRadar() {
        if animationView != nil {
            self.animationView.play()
        } else {
            self.animationView?.removeFromSuperview()
            self.animationView = .init(name: "radar-animation")
            self.animationView.frame = self.radarView.bounds
            self.animationView.contentMode = .scaleAspectFill
            self.animationView.loopMode = .loop
            self.animationView.animationSpeed = 0.6
            self.radarView.addSubview(self.animationView)
            self.animationView.play()
        }
    }
}

struct DeviceDistanceViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            DeviceDistanceViewController()
        }
    }
}
