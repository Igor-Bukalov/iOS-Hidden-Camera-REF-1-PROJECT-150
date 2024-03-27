//
//  LoadingViewController.swift
//  Hidden Spy Camera Finder
//
//  Created by Igor Bowtie on 26.03.2024.
//

import UIKit
import TinyConstraints
import SwiftUI

class LoadingViewController: UIViewController {
    let progressLayer = CAShapeLayer()
    let statusLabel = UILabel()
    
    var onLoadingComplete: (() -> ())?
    
    var progress: CGFloat = 0 {
        didSet {
            DispatchQueue.main.async {
                self.statusLabel.text = "\(Int(self.progress * 100))%"
                if self.progress >= 1.0 {
                    self.statusLabel.text = "100%"
                    self.onLoadingComplete?()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.customBackground
        setupStatusLabel()
        setupProgressLayer()
        startLoading()
    }
    
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    private func setupProgressLayer() {
        let radius: CGFloat = isiPad ? 176 : 88
        let center = view.center
        let circularPath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: -CGFloat.pi / 2,
            endAngle: 3 * CGFloat.pi / 2,
            clockwise: true
        )
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.customCellBackground.cgColor
        trackLayer.lineWidth = isiPad ? 30 : 16
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        view.layer.addSublayer(trackLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.customLightBlue.cgColor
        progressLayer.lineWidth = isiPad ? 30 : 16
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        view.layer.addSublayer(progressLayer)
    }
    
    private func setupStatusLabel() {
        view.addSubview(statusLabel)
        statusLabel.centerInSuperview()
        
        statusLabel.text = "0%"
        statusLabel.font = UIFont.gilroy(.medium, size: isiPad ? 44 : 28)
        statusLabel.textAlignment = .center
    }
    
    private func startLoading() {
        let duration: TimeInterval = 1
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        progressLayer.add(animation, forKey: "progressAnim")
        
        var counter: Int = 0
        let increment = 1
        Timer.scheduledTimer(withTimeInterval: duration / 100, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            if counter < 100 {
                counter += increment
                self.progress = CGFloat(counter) / 100
            } else {
                timer.invalidate()
            }
        }.fire()
    }
    
    func showNoInternetConnectionAlert() {
        let alertController = UIAlertController(title: "No Internet Connection", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

struct LoadingViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            LoadingViewController()
        }
    }
}
