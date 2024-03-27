//
//  UIViewController+Ext.swift
//  Hidden Spy Camera Finder
//
//  Created by Igor Bowtie on 26.03.2024.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String? = nil, message: String? = nil, preferredStyle: UIAlertController.Style, sender: UIView? = nil, positiveTitle: String? = nil, negativeTitle: String? = nil, onPositive: ((UIAlertAction) -> Void)? = nil, onNegative: ((UIAlertAction) -> Void)? = nil, onPresented: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if let positiveTitle = positiveTitle {
            alertController.addAction(UIAlertAction(title: positiveTitle, style: .default, handler: onPositive))
        }
        if let negativeTitle = negativeTitle {
            alertController.addAction(UIAlertAction(title: negativeTitle, style: .cancel, handler: onNegative))
        }
        
        if let popover = alertController.popoverPresentationController, let sourceView = sender {
            popover.sourceView = sourceView
            popover.sourceRect = sourceView.bounds
        }
        
        present(alertController, animated: true, completion: onPresented)
    }
}

extension UIViewController {
    func push(_ wrappedController: WrappedController, animated: Bool) {
        navigationController?.pushViewController(wrappedController.viewController, animated: animated)
    }
}
