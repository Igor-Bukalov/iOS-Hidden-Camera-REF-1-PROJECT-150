//
//  AntiSpyMenuCell.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 14.11.2023.
//

import UIKit

class AntiSpyMenuCell: UITableViewCell {
    @IBOutlet var labels: [UILabel]!
    
    var completion: ((AntiSpyViewController.Action_anti_spy) -> Void)?
    
    @IBAction func cameraObscuraTapped(_ sender: UIButton) {
        completion?(.cameraObscura)
    }
    @IBAction func infraredCameraTapped(_ sender: UIButton) {
        completion?(.infraredCamera)
    }
    @IBAction func wirelessObscura(_ sender: UIButton) {
        completion?(.wirelessObscura)
    }
    @IBAction func wiredObscuraTapped(_ sender: UIButton) {
        completion?(.wiredObscure)
    }
    @IBAction func sleepCamera(_ sender: UIButton) {
        completion?(.sleepCamera)
    }
    @IBAction func otherTapped(_ sender: UIButton) {
        completion?(.other)
    }
}
