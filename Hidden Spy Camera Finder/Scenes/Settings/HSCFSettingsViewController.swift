//
//  SettingsViewController.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 06.11.2023.
//

import UIKit
import TinyConstraints
import CoreLocation
import SafariServices
import SwiftUI

class HSCFSettingsViewController: HSCFBaseViewController {
    enum Section_settings: CaseIterable {
        case antiPhotographyTechnology, wifiInfo, userAgreements
        
        enum AntiPhotographyTechnology: String, CaseIterable {
            case antiPhotographyTechnology = "Anti-photography technology"
        }
        
        enum WifiInfo: String, CaseIterable {
            case wirelessLocalNetwork = "Wireless local network"
            case wifiIP = "Wi-Fi IP"
            case `operator` = "Operator"
            case broadcastAddressWifi = "Broadcast address Wi-Fi"
            case wifiRouterAddress = "Wi-Fi router address"
        }
        
        enum UserAgreements: String, CaseIterable {
            case privacyPolicy = "Privacy policy"
            case termsOfService = "Terms of service"
        }
        
        var rows: [AnyHashable] {
            switch self {
            case .antiPhotographyTechnology:
                return AntiPhotographyTechnology.allCases
            case .wifiInfo:
                return WifiInfo.allCases
            case .userAgreements:
                return UserAgreements.allCases
            }
        }
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section_settings, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section_settings, AnyHashable>
    
    // MARK: - Properties
    private static let cellIdentifier = "settings.cell.identifier"
    private var locationManager: HSCFLocation_HS_Mnrg?
    
    private var operatorName: String? = HSCFDeviceInfo.shared.getOperator()
    private var currentNetworkInfos: Array<NetworkInfo_HSCF>? {
        get { return SSID.fetchNetworkInfo_HSCF() }
    }
    
    // MARK: - UIProperties
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.backgroundColor = .clear
        table.delegate = self
        return table
    }()
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cornerRadius: CGFloat = 16
        
        let layer = CAShapeLayer()
        let pathRef = CGMutablePath()
        let bounds = cell.bounds.insetBy(dx: 0.5, dy: 0.5)
        var addLine = false
        
        setCornerRadiusForSectionCell(cell: cell, indexPath: indexPath, tableView: tableView, needSetAlone: false, cellY: 0)
        
        if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
        } else if indexPath.row == 0 {
            pathRef.move(to: .init(x: bounds.minX, y: bounds.maxY+1))
            pathRef.addArc(tangent1End: .init(x: bounds.minX, y: bounds.minY), tangent2End: .init(x: bounds.midX, y: bounds.minY), radius: cornerRadius)
            pathRef.addArc(tangent1End: .init(x: bounds.maxX, y: bounds.minY), tangent2End: .init(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            pathRef.addLine(to: .init(x: bounds.maxX, y: bounds.maxY+1))
            addLine = true
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            pathRef.move(to: .init(x: bounds.minX, y: bounds.minY-1))
            pathRef.addArc(tangent1End: .init(x: bounds.minX, y: bounds.maxY), tangent2End: .init(x: bounds.midX, y: bounds.maxY), radius: cornerRadius)
            pathRef.addArc(tangent1End: .init(x: bounds.maxX, y: bounds.maxY), tangent2End: .init(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            pathRef.addLine(to: .init(x: bounds.maxX, y: bounds.minY-1))
        } else {
            let pathInnerRef = CGMutablePath()
            pathInnerRef.move(to: .init(x: bounds.minX, y: bounds.minY-1))
            pathInnerRef.addLine(to: .init(x: bounds.minX, y: bounds.maxY+1))
            
            pathInnerRef.move(to: .init(x: bounds.maxX, y: bounds.minY-1))
            pathInnerRef.addLine(to: .init(x: bounds.maxX, y: bounds.maxY+1))
            pathRef.addPath(pathInnerRef)
            addLine = true
        }
        
        layer.path = pathRef
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.blueLabel.cgColor
        
        if (addLine == true) {
            let lineLayer = CALayer()
            let lineHeight = 1 / UIScreen.main.scale
            lineLayer.frame = CGRect(x: bounds.minX + 15, y: bounds.size.height - lineHeight, width: bounds.size.width - 30, height: lineHeight)
            lineLayer.backgroundColor = UIColor.clear.cgColor
            lineLayer.borderColor = UIColor.hex("4680E4").cgColor
            lineLayer.opacity = 0.7
            lineLayer.borderWidth = 0.5
            layer.addSublayer(lineLayer)
        }
        
        let testView = UIView(frame: bounds)
        testView.layer.insertSublayer(layer, at: 0)
        testView.backgroundColor = .clear
        
        cell.backgroundView = testView
    }
    
    private lazy var dataSource: DataSource = DataSource(tableView: tableView) { [weak self] tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: HSCFSettingsViewController.cellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        if let item = item as? HSCFSettingsViewController.Section_settings.AntiPhotographyTechnology {
            content.textProperties.color = .blueLabel
            content.text = item.rawValue
            let imgView = UIImageView(image: UIImage(systemName: "chevron.right"))
            imgView.tintColor = .blueLabel
            cell.accessoryView = imgView
        } else if let item = item as? HSCFSettingsViewController.Section_settings.WifiInfo {
            content.textProperties.color = UIColor.blueLabel
            content.text = item.rawValue
            let label = UILabel(frame: CGRect(x:0,y:0,width:100,height:20))
            label.font = UIFont.gilroy(.GilroyMedium, size: 14)
            label.textAlignment = .right
            label.textColor = UIColor.hex("4680E4")
            label.text = item.rightText
            cell.accessoryView = label
            if item == .wirelessLocalNetwork {
                if let ssid = self?.currentNetworkInfos?.first?.ssid {
                    label.text = ssid
                }
            }
            if item == .operator {
                label.text = self?.operatorName
            }
        } else if let item = item as? HSCFSettingsViewController.Section_settings.UserAgreements {
            content.textProperties.color = .blueLabel
            content.text = item.rawValue
            let imgView = UIImageView(image: UIImage(systemName: "chevron.right"))
            imgView.tintColor = .blueLabel
            cell.accessoryView = imgView
        }
        content.textProperties.font = UIFont.gilroy(.GilroyMedium, size: 16)
        cell.contentConfiguration = content
        cell.backgroundColor = UIColor.cellBackground
        cell.layer.masksToBounds = true
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView_HSCF()
        prepareData_HSCF()
        
        locationManager = HSCFLocation_HS_Mnrg(delegate: self)
        locationManager?.askForAccess()
        updateOperator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Logic
    private func configureTableView_HSCF() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.edgesToSuperview()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: HSCFSettingsViewController.cellIdentifier)
    }
    
    private func prepareData_HSCF() {
        dataSource.apply(makeSnapshot())
    }
    
    private func clearDataSource_HSCF() {
        tableView.reloadData()
    }
    
    private func makeSnapshot() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections(Section_settings.allCases.map { $0 })
        Section_settings.allCases.forEach {
            snapshot.appendItems($0.rows, toSection: $0)
        }
        return snapshot
    }
    
    private func updateWiFi_HSCF_3() {
        tableView.reloadData()
    }
    
    private func updateOperator() {
        if HSCFNetworkMonitor.shared.isConnected {
            if HSCFNetworkMonitor.shared.currentConnectionType == .cellular {
                HSCFDeviceInfo.shared.getOperatorName { [weak self] operatorModel in
                    DispatchQueue.main.async { [weak self] in
                        if let op = operatorModel?.org {
                            HSCFCoreDataManager.shared.saveOperator(name: op)
                            self?.operatorName = op
                            self?.tableView.reloadData()
                        }
                    }
                }
            } else {
                self.operatorName = "Internet"
                self.tableView.reloadData()
            }
        } else {
            self.operatorName = HSCFCoreDataManager.shared.getOperatorName() ?? .na
            self.tableView.reloadData()
        }
    }
    
    func show(_ urlString: String) {
        if let url = URL(string: urlString) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}

extension HSCFSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ((dataSource.itemIdentifier(for: indexPath) as? HSCFSettingsViewController.Section_settings.AntiPhotographyTechnology) != nil) {
            pushViewControllerHSCF(Controller_HSCF.tutorial, animated: true)
        } else if let item = dataSource.itemIdentifier(for: indexPath) as? HSCFSettingsViewController.Section_settings.UserAgreements {
            switch item {
            case .privacyPolicy:
                show("https://google.com")
            case .termsOfService:
                show("https://google.com")
            }
        }
    }
}

extension HSCFSettingsViewController.Section_settings.WifiInfo {
    var rightText: String {
        switch self {
        case .wirelessLocalNetwork:
            return ""
        case .wifiIP:
            return HSCFDeviceInfo.shared.getWiFiAddress() ?? .na
        case .operator:
            return HSCFDeviceInfo.shared.getOperator() ?? .na
        case .broadcastAddressWifi:
            return HSCFDeviceInfo.shared.broadcastWIFIAddress() ?? .na
        case .wifiRouterAddress:
            return HSCFDeviceInfo.shared.wifiRouterAddress() ?? .na
        }
    }
}

extension HSCFSettingsViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            updateWiFi_HSCF_3()
        }
    }
}

extension HSCFSettingsViewController {
    /// Set Cell Round
    /// - Parameters:
    ///   - cell: cell
    ///   - indexPath: indexPath
    ///   - tableView: tableView
    /// - NEEDSETALONE: Do you need a separate setting of each Cell. The default is set as a unit of unit, if a section is only one Cell, all sets
    public func setCornerRadiusForSectionCell(cell: UITableViewCell, indexPath: IndexPath, tableView: UITableView, needSetAlone: Bool, cellY: CGFloat) {
        // Rounded radius
        let cornerRadius: CGFloat = 16
        
        // below to set the rounded operation (achieved by mask)
        let sectionCount = tableView.numberOfRows(inSection: indexPath.section)
        let shapeLayer = CAShapeLayer()
        cell.layer.mask = nil
        
        if needSetAlone {
            let bezierPath = UIBezierPath(
                roundedRect: cell.bounds.insetBy(dx: 0.0, dy: cellY),
                cornerRadius: cornerRadius
            )
            shapeLayer.path = bezierPath.cgPath
            cell.layer.mask = shapeLayer
        } else {
            // When there is multi-line data in the current partition
            if sectionCount > 1 {
                switch indexPath.row {
                // If it is the first line, on the left, the upper right corner is rounded
                case 0:
                    var bounds = cell.bounds
                    bounds.origin.y += 0  // This part of each set of first line is not displayed
                    let bezierPath = UIBezierPath(
                        roundedRect: bounds,
                        byRoundingCorners: [.topLeft, .topRight],
                        cornerRadii: CGSize(width: cornerRadius,height: cornerRadius)
                    )
                    shapeLayer.path = bezierPath.cgPath
                    cell.layer.mask = shapeLayer
                // If it is the last row, the lower left, the lower right corner is rounded
                case sectionCount - 1:
                    var bounds = cell.bounds
                    bounds.size.height -= 0  // This part of each group is not displayed
                    let bezierPath = UIBezierPath(
                        roundedRect: bounds,
                        byRoundingCorners: [.bottomLeft,.bottomRight],
                        cornerRadii: CGSize(width: cornerRadius,height: cornerRadius)
                    )
                    shapeLayer.path = bezierPath.cgPath
                    cell.layer.mask = shapeLayer
                default:
                    break
                }
            } else {
                // Four corners are rounded (same setting offset hidden, tail separation)
                let bezierPath = UIBezierPath(
                    roundedRect: cell.bounds.insetBy(dx: 0.0, dy: cellY),
                    cornerRadius: cornerRadius
                )
                shapeLayer.path = bezierPath.cgPath
                cell.layer.mask = shapeLayer
            }
        }
    }
}

struct HSCFSettingsViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            HSCFSettingsViewController()
        }
    }
}
