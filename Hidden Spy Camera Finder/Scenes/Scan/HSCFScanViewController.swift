//
//  ScanViewController.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 06.11.2023.
//

import UIKit
import TinyConstraints
import CoreBluetooth
import Lottie
//import LanScanner
import Network
import SwiftUI

class HSCFScanViewController: HSCFBaseViewController, LanScannerDelegate2 {
    enum ScanningState {
        case startDetection, checking, results
        var title: String {
            switch self {
            case .startDetection: return "Start detection"
            case .checking: return "Checking..."
            case .results: return "Results"
            }
        }
    }
    
    // MARK: - UIProperties
    private lazy var detectionButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.buttonBlueBackground
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = UIFont.gilroy(.GilroyMedium, size: isiPad ? 30 : 18)
        b.layer.cornerRadius = isiPad ? 33 : 20
        b.setTitle(ScanningState.startDetection.title, for: .normal)
        b.addTarget(self, action: #selector(scanningTapped), for: .touchUpInside)
        return b
    }()
    
    private lazy var reviewButton: UIButton = {
        let b = UIButton()
        b.layer.borderColor = UIColor.buttonGreyBorder.cgColor
        b.layer.borderWidth = 1
        b.titleLabel?.font = UIFont.gilroy(.GilroyMedium, size: isiPad ? 30 : 18)
        b.setTitleColor(UIColor.buttonGreyText, for: .normal)
        b.layer.cornerRadius = isiPad ? 33 : 20
        b.setTitle("Review", for: .normal)
        b.addTarget(self, action: #selector(reviewTapped), for: .touchUpInside)
        return b
    }()
    
    private lazy var suspiciousDevicesFound: UILabel = {
        let l = UILabel()
        l.font = UIFont.gilroy(.GilroyMedium, size: isiPad ? 30 : 18)
        l.textColor = UIColor.blueLabel
        l.textAlignment = .center
        l.text = "Suspicious devices found: 0"
        return l
    }()
    
    private lazy var wifiIPAddress: UILabel = {
        let l = UILabel()
        l.font = UIFont.gilroy(.GilroyMedium, size: isiPad ? 26 : 16)
        l.textColor = UIColor.blueLabel
        l.textAlignment = .center
//        l.text = "Wi-Fi IP: \(HSCFDeviceInfo.shared.getWiFiAddress() ?? .na)"
        l.text = "Wi-Fi IP: \(HSCFDeviceInfo.shared.wifiRouterAddress() ?? .na)"
        return l
    }()
    
    private lazy var radarView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    private lazy var radarImageView: UIImageView = UIImageView(image: UIImage(named: "scanning-loader"))
    private lazy var radarProgressImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "scanning-loader-in-progress"))
        img.layer.opacity = 0.0
        return img
    }()
    
    // MARK: - Properties
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    private lazy var networkPermsissionService = LocalNetworkPermissionService()
    private lazy var scanner = LanScannerService(delegate: self)
    private var connectedDevices = [LanDevice2]() {
        didSet { self.suspiciousDevicesFound.text = "Suspicious devices found: " + String(connectedDevices.count) }
    }
    
    private var animationView: LottieAnimationView!
    private var scanningState = ScanningState.startDetection {
        didSet { detectionButton.setTitle(scanningState.title, for: .normal); isDisableReviewButton(scanningState != .results) }
    }
    private var currentNetworkInfos: Array<NetworkInfo_HSCF>? {
        get { return SSID.fetchNetworkInfo_HSCF() }
    }
    private var locationManager: HSCFLocation_HS_Mnrg?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        internerConntectionHandle()
        prepareUI_S32HP()
        locationManager = HSCFLocation_HS_Mnrg()
        locationManager?.askForAccess()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public func tryStartScan() {
        if scanningState == .startDetection {
            startScan()
        }
    }
    
    private func prepareUI_S32HP() {
        prepareSubviews()
    }
    
    private func prepareSubviews() {
        let stackView = UIView()
        stackView.stack([reviewButton, detectionButton], axis: .vertical, spacing: isiPad ? 20 : 12)
        view.addSubview(stackView)
        
        if isiPad {
            stackView.centerXToSuperview()
            stackView.bottomToSuperview(offset: -26, usingSafeArea: true)
            reviewButton.width(560)
            detectionButton.width(560)
            reviewButton.height(95)
            detectionButton.height(95)
        } else {
            stackView.leftToSuperview(offset: 20)
            stackView.rightToSuperview(offset: -20)
            stackView.bottomToSuperview(offset: -16, usingSafeArea: true)
            reviewButton.height(56)
            detectionButton.height(56)
        }
        
        let stackViewSecond = UIView()
        stackViewSecond.stack([suspiciousDevicesFound, wifiIPAddress], axis: .vertical, spacing: isiPad ? 13 : 8)
        view.addSubview(stackViewSecond)
        
        stackViewSecond.topToSuperview(offset: isiPad ? 26 : 16, usingSafeArea: true)
        stackViewSecond.centerXToSuperview()
        stackViewSecond.height(isiPad ? 81 : 48)
        
        view.addSubview(radarView)
        
        if isiPad {
            radarView.topToBottom(of: stackViewSecond, offset: 40)
            radarView.centerXToSuperview()
            radarView.width(560)
            radarView.aspectRatio(1)
        } else {
            radarView.topToBottom(of: stackViewSecond, offset: 24)
            radarView.leftToSuperview(offset: 20, usingSafeArea: true)
            radarView.rightToSuperview(offset: -20, usingSafeArea: true)
            radarView.aspectRatio(1)
        }
        
        radarView.addSubview(radarImageView)
        radarImageView.edgesToSuperview()
        
        radarView.addSubview(radarProgressImageView)
        radarProgressImageView.edgesToSuperview()
    }
    
    private func animateRadar() {
//        if animationView != nil {
//            self.animationView.play()
//        } else {
//            self.animationView?.removeFromSuperview()
//            self.animationView = .init(name: "Radar")
//            self.animationView.frame = self.radarView.bounds
//            self.animationView.contentMode = .scaleAspectFill
//            self.animationView.loopMode = .loop
//            self.animationView.animationSpeed = 0.5
//            self.animationView.layer.cornerRadius = self.radarView.frame.height / 2
//            self.radarView.addSubview(self.animationView)
//            self.animationView.play()
//        }
        
        self.radarImageView.layer.opacity = 0.0
        self.radarProgressImageView.layer.opacity = 1.0
    }
    
    private func stopAnimateRadar() {
        self.animationView?.stop()
        self.animationView?.removeFromSuperview()
    }
    
    private func showAlertWith_HSCF(state: CBManagerState) {
        self.showAlert(title: state.alertTitle, message: state.alertSubtitle, style: .alert, okButtonTitle: state.alertActionTitle, cancelButtonTitle: "Cancel", okHandler: { _ in
            state.action()
        }, cancelHandler: { _ in })
    }
    
    private func startScan() {
        if HSCFNetworkMonitor.shared.isConnected {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
                if HSCFNetworkMonitor.shared.currentConnectionType == .cellular {
                    self?.results()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 20) { [weak self] in
                        if self?.connectedDevices.count == 0 {
                            self?.results()
                        }
                    }
                }
            }
            connectedDevices.removeAll()
            scanner.start()
            
            animateRadar()
            scanningState = .checking
        } else {
            
        }
    }
    
    private func stopScan() {
        self.radarImageView.layer.opacity = 1.0
        self.radarProgressImageView.layer.opacity = 0.0
        
        self.animationView?.pause()
        scanner.stop()
        scanningState = .startDetection
    }
    
    private func results() {
        self.radarImageView.layer.opacity = 1.0
        self.radarProgressImageView.layer.opacity = 0.0
        
        self.animationView?.pause()
        scanner.stop()
        scanningState = .results
        let router = currentNetworkInfos?.first
        let devices = getDevcies()
        HSCFCoreDataManager.shared.save_HSCF(wifiName: router?.ssid ?? .na, wifiIP: HSCFDeviceInfo.shared.getWiFiAddress() ?? .na, wifiInterface: router?.interface ?? .na, devices: devices)
    }
    
    private func getDevcies() -> [LanModel] {
        let jsonData = macJsonData() ?? []
        return connectedDevices.map { item in
            let brand = jsonData.first(where: { $0.mac == item.mac } )
            let name: String = item.name.contains(item.ipAddress) ? String.unknown : item.name
            return LanModel(name: name, ipAddress: item.ipAddress, mac: item.mac, brand: item.brand.isEmpty ? brand?.brandName : item.brand)
        }
    }
    
    private func isDisableReviewButton(_ isDisable: Bool) {
        reviewButton.layer.borderColor = isDisable ? UIColor.buttonGreyBorder.cgColor : UIColor.buttonBlueBorder.cgColor
        reviewButton.setTitleColor(isDisable ? UIColor.buttonGreyText : UIColor.buttonBlueText, for: .normal)
    }
    
    // MARK: - Actions
    @objc
    func scanningTapped() {
        networkPermsissionService.triggerDialog()
        switch scanningState {
        case .startDetection:
            startScan()
            detectionButton.bounce(level: .low)
        case .checking:
            break
        case .results:
            detectionButton.bounce(level: .low)
            guard let vc = Controller_HSCF.scanDetails.controller as? ScanDetailsViewController else { return }
            let devices = getDevcies()
            vc.peripheralItems = devices
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc
    func reviewTapped() {
        if scanningState == .results {
            scanningState = .startDetection
            startScan()
            reviewButton.bounce(level: .low)
        }
    }
    
    func lanScanHasUpdatedProgress(_ progress: CGFloat, address: String) {
        print("Progress: ", progress)
    }
    
    func lanScanDidFindNewDevice(_ device: LanDevice2) {
        connectedDevices.append(device)
    }
    
    func lanScanDidFinishScanning(_ lanDevices: [LanDevice2]) {
        connectedDevices = lanDevices
        self.results()
    }
    
    func lanScanDidFinishScanning() {
        self.results()
    }
}

extension LanDevice2: Identifiable {
    public var id: UUID { .init() }
}

func getCorrectMacAddress(ip: String, macAddress: String) -> String? {
    if macAddress != "02:00:00:00:00:00" {
        return macAddress
    } else if let mac = GetMACAddressFromIPv6(ip: ip) {
        return mac
    } else if let mac = LanScan2().getMacAddress(ip) {
        return mac
    } else {
        return nil
    }
}

func GetMACAddressFromIPv6(ip: String) -> String? {
    let IPStruct = IPv6Address(ip)
    if IPStruct == nil {
        return nil
    }
    let extractedMAC = [
        (IPStruct?.rawValue[8])! ^ 0b00000010,
        IPStruct?.rawValue[9],
        IPStruct?.rawValue[10],
        IPStruct?.rawValue[13],
        IPStruct?.rawValue[14],
        IPStruct?.rawValue[15]
    ]
    return String(format: "%02x:%02x:%02x:%02x:%02x:%02x",
                  extractedMAC[0] ?? 00,
                  extractedMAC[1] ?? 00,
                  extractedMAC[2] ?? 00,
                  extractedMAC[3] ?? 00,
                  extractedMAC[4] ?? 00,
                  extractedMAC[5] ?? 00)
}

struct HSCFScanViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            GSDA_ContainerForMenuController_GSD()
        }
    }
}
