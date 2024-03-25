//
//  AlertView.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 15.11.2023.
//

import Foundation
import UIKit
import SwiftUI

class HSCFAlertView: UIView {
    static let instance = HSCFAlertView()
    
    // MARK: - @IBOutlets
    @IBOutlet private var parentView: UIView!
    @IBOutlet private weak var alertView: UIView!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var messageLbl: UILabel!
    @IBOutlet private weak var doneBtn: UIButton!
    @IBOutlet private weak var rightActionButton: UIButton!
    @IBOutlet private weak var leftActionButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actionButtonsStackView: UIStackView!
    
    // MARK: - Properties
    private var leftActionClosure: (() -> Void)?
    private var rightActionClosure: (() -> Void)?
    
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        Bundle.main.loadNibNamed("HSCFAlertView", owner: self, options: nil)
        commonInit_HSCF()
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.parentView.alpha = 1
            self?.layoutIfNeeded()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit_HSCF() {
        let screenWidth = UIScreen.main.bounds.width
        let alertWidth = isiPad ? screenWidth * 0.5 : screenWidth * 0.8
        
        rightActionButton.addTarget(self, action: #selector(rightAction_HSCF), for: .touchUpInside)
        leftActionButton.addTarget(self, action: #selector(leftAction_HSCF), for: .touchUpInside)
        
        alertView.layer.cornerRadius = isiPad ? 20 : 12
        
        parentView.frame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        titleLbl.font = UIFont.gilroy(.GilroyMedium, size: isiPad ? 26 : 18)
        messageLbl.font = UIFont.gilroy(.GilroySemibold, size: isiPad ? 20 : 14)
        
        rightActionButton.titleLabel?.font = UIFont.gilroy(.GilroyMedium, size: isiPad ? 26 : 16)
        leftActionButton.titleLabel?.font = UIFont.gilroy(.GilroyMedium, size: isiPad ? 26 : 16)
        
        leftActionButton.layer.borderColor = UIColor.white.cgColor
        leftActionButton.layer.borderWidth = 1
    }
    
    func showAlert_HSCF(
        showImage: Bool = false,
        title: String,
        message: String? = nil,
        leftActionTitle: String? = nil,
        rightActionTitle: String? = nil,
        leftAction: (() -> Void)? = nil,
        rightAction: (() -> Void)? = nil
    ) {
        self.imageView.isHidden = !showImage
        
        self.titleLbl.text = title
        self.messageLbl.text = message
        
        actionButtonsStackView.isHidden = leftActionTitle == nil && rightActionTitle == nil
        
        self.leftActionClosure = leftAction
        self.rightActionClosure = rightAction
        
        self.leftActionButton.setTitle(leftActionTitle, for: .normal)
        self.rightActionButton.setTitle(rightActionTitle, for: .normal)
        
        leftActionButton.isHidden = leftActionTitle == nil
        rightActionButton.isHidden = rightActionTitle == nil
        
        let keyWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.filter { $0.isKeyWindow }.first
        
        keyWindow?.addSubview(parentView)
        
        if leftActionTitle == nil && rightActionTitle == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) { [weak self] in
                self?.parentView.removeFromSuperview()
            }
        }
    }
    
    private func dismiss_HSCF() {
        self.parentView.removeFromSuperview()
    }
    
    // MARK: - Actions
    @objc
    private func leftAction_HSCF() {
        self.leftActionClosure?()
        dismiss_HSCF()
    }
    
    @objc
    private func rightAction_HSCF() {
        self.rightActionClosure?()
        dismiss_HSCF()
    }
}
