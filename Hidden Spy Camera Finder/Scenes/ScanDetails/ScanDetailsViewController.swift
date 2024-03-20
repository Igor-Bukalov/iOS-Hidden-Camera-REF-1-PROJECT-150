//
//  ScanDetailsViewController.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 09.11.2023.
//

import UIKit
import TinyConstraints
import CoreLocation
import Lottie
import SwiftUI

class ScanDetailsViewController: HSCFBaseViewController, CLLocationManagerDelegate {
    enum Section_scan_detail: Int, CaseIterable {
        case mainInfo, alert, peripheralItems, emptyCell
    }
    
    enum ItemValue {
        case emptyCell, alert
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section_scan_detail, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section_scan_detail, AnyHashable>
    
    // MARK: - UIProperties
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.backgroundColor = .clear
        table.sectionHeaderHeight = 10
        table.sectionFooterHeight = 10
        return table
    }()
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cornerRadius: CGFloat = 16
        
        let layer = CAShapeLayer()
        let pathRef = CGMutablePath()
        let bounds = cell.bounds.insetBy(dx: 0.5, dy: 0.1)
        var addLine = false
        
        setCornerRadiusForSectionCell(cell: cell, indexPath: indexPath, tableView: tableView, needSetAlone: false, cellY: 0)
        
        if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
        } else if indexPath.row == 0 {
            pathRef.move(to: .init(x: bounds.minX, y: bounds.maxY))
            pathRef.addArc(tangent1End: .init(x: bounds.minX, y: bounds.minY), tangent2End: .init(x: bounds.midX, y: bounds.minY), radius: cornerRadius)
            pathRef.addArc(tangent1End: .init(x: bounds.maxX, y: bounds.minY), tangent2End: .init(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            pathRef.addLine(to: .init(x: bounds.maxX, y: bounds.maxY))
            addLine = true
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            pathRef.move(to: .init(x: bounds.minX, y: bounds.minY))
            pathRef.addArc(tangent1End: .init(x: bounds.minX, y: bounds.maxY), tangent2End: .init(x: bounds.midX, y: bounds.maxY), radius: cornerRadius)
            pathRef.addArc(tangent1End: .init(x: bounds.maxX, y: bounds.maxY), tangent2End: .init(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            pathRef.addLine(to: .init(x: bounds.maxX, y: bounds.minY))
        } else {
            let pathInnerRef = CGMutablePath()
            pathInnerRef.move(to: .init(x: bounds.minX, y: bounds.minY))
            pathInnerRef.addLine(to: .init(x: bounds.minX, y: bounds.maxY))
            
            pathInnerRef.move(to: .init(x: bounds.maxX, y: bounds.minY))
            pathInnerRef.addLine(to: .init(x: bounds.maxX, y: bounds.maxY))
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
    
    // MARK: - Properties
    private lazy var dataSource: DataSource = DataSource(tableView: tableView) { [weak self] tableView, indexPath, item in
        if let item = item as? TextModel {
            guard let scanCell = tableView.dequeueReusableCell(withIdentifier: "ScanDetailCell", for: indexPath) as? ScanDetailCell else { return UITableViewCell() }
            scanCell.titleTextLabel.text = item.subTitleValue
            scanCell.titleValueButton.setTitle(item.titleValue, for: .normal)
            scanCell.subTitleTextLabel.text = item.subTitle
            scanCell.subTitleValueLabel.text = item.title
            
            scanCell.titleValueButton.setTitleColor(item.title.isEmpty ? UIColor.hex("4680E4").withAlphaComponent(0.3) : UIColor.hex("4680E4"), for: .normal)
            scanCell.titleValueButton.isEnabled = item.title.isEmpty ? false : true
            if item.titleValue != "Copy Mac" { scanCell.titleValueButton.setTitleColor(UIColor.blueLabel, for: .normal) }
            
            if item.title == .unknown {
                scanCell.titleValueButton.isEnabled = false
            } else {
                scanCell.titleValueButton.isEnabled = true
            }
            
            scanCell.titleValueButton.alpha = item.title == .unknown ? 0.3 : 1
            
            if item.titleValue != "Copy Mac" {
                scanCell.titleTextLabel.text = item.title
                scanCell.subTitleValueLabel.text = item.subTitleValue
            }
            
            scanCell.actionTapped = {
                UIPasteboard.general.string = item.title
                HSCFAlertView.instance.showAlert_HSCF(showImage: true, title: "The copying was successful!")
            }
            
//            self!.setCornerRadiusForSectionCell(cell: scanCell, indexPath: indexPath, tableView: tableView, needSetAlone: false, cellY: 0)
            
            return scanCell
        } else if let item = item as? ItemValue {
            switch item {
            case .emptyCell:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyStateCell", for: indexPath) as? EmptyStateCell else { return UITableViewCell() }
                cell.titleLabel.text = "No other devices are found on the current network"
                return cell
            case .alert:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScanDetailTextCell", for: indexPath) as? ScanDetailTextCell else { return UITableViewCell() }
                return cell
            }
        } else {
            return UITableViewCell()
        }
    }
    
    private var locationManager: HSCFLocation_HS_Mnrg?
    private var currentNetworkInfos: Array<NetworkInfo_HSCF>? {
        get { return SSID.fetchNetworkInfo_HSCF() }
    }
    
    public var peripheralItems: [LanModel] = []
    public var routerInfo: (wifiName: String, wifiIp: String, routerInterface: String?)?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews_S32HP()
        configureTableView_HSCF()
        
        locationManager = HSCFLocation_HS_Mnrg(delegate: self)
        locationManager?.askForAccess()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        asd2_prepareData_HSCF()
    }
    
    // MARK: - Logic
    private func configureTableView_HSCF() {
        view.addSubview(tableView)
        tableView.edgesToSuperview()
        tableView.register(ScanDetailCell.nib, forCellReuseIdentifier: "ScanDetailCell")
        tableView.register(ScanDetailTextCell.self, forCellReuseIdentifier: "ScanDetailTextCell")
        tableView.register(EmptyStateCell.self, forCellReuseIdentifier: "EmptyStateCell")
    }
    
    private func asd2_prepareData_HSCF() {
        var items: [(Section_scan_detail, [AnyHashable])] = []
        let deviceName = UIDevice.current.userInterfaceIdiom == .pad ? "iPad" : "iPhone"
        var mainInfo = [ScanDetailsViewController.TextModel(
            title: deviceName,
            titleValue: "Own",
            subTitle: HSCFDeviceInfo.shared.getWiFiAddress() ?? .na,
            subTitleValue: "Apple, Inc."
        )]
        if let routerInfo {
            mainInfo.append(ScanDetailsViewController.TextModel(
                title: routerInfo.wifiName,
                titleValue: "Router",
                subTitle: routerInfo.wifiIp,
                subTitleValue: routerInfo.routerInterface ?? .na
            ))
        } else if let router = currentNetworkInfos?.first, let ssid = router.ssid {
            mainInfo.append(ScanDetailsViewController.TextModel(
                title: ssid,
                titleValue: "Router",
                subTitle: HSCFDeviceInfo.shared.getWiFiAddress() ?? .na,
                subTitleValue: router.interface
            ))
        }
        let peripheralItems: [ScanDetailsViewController.TextModel] = peripheralItems.compactMap {
            return TextModel(title: $0.mac ?? .unknown, titleValue: "Copy Mac", subTitle: $0.ipAddress, subTitleValue: $0.name)
        }
        
        items = [
            (Section_scan_detail.mainInfo, mainInfo),
            (Section_scan_detail.alert, [ItemValue.alert]),
        ]
        
        if !peripheralItems.isEmpty {
            items.append((Section_scan_detail.peripheralItems, peripheralItems))
        } else {
            items.append((Section_scan_detail.emptyCell, [ItemValue.emptyCell]))
        }
        
        dataSource.apply(makeSnapshot(items: items))
    }
    
    private func makeSnapshot(items: [(Section_scan_detail, [AnyHashable])]) -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections(items.map { $0.0 })
        items.forEach { section, items in
            snapshot.appendItems(items, toSection: section)
        }
        return snapshot
    }
    
    private func setupSubviews_S32HP() {
        view.addSubview(tableView)
        tableView.edgesToSuperview(usingSafeArea: true)
    }
    
    private func updateWiFi_HSCF() {
        self.asd2_prepareData_HSCF()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            updateWiFi_HSCF()
        }
    }

    struct TextModel: Hashable {
        let title: String
        let titleValue: String
        
        let subTitle: String
        let subTitleValue: String
    }
}

extension ScanDetailsViewController {
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

struct ScanDetailsViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            ScanDetailsViewController()
        }
    }
}