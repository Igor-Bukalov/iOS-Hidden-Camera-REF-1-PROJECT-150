//
//  AntiSpyDetails.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 14.11.2023.
//

import UIKit
import TinyConstraints
import SwiftUI

class AntiSpyDetailsViewController: HSCFBaseViewController {
    enum SelectType {
        case all
        case cameraObscura
        case infraredCamera
        case wirelessObscura
        case wiredObscura
        case sleepCamera
        case other
    }
    
    typealias DataSource = UITableViewDiffableDataSource<AnyHashable, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<AnyHashable, AnyHashable>
    
    // MARK: - UIProperties
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.backgroundColor = .clear
        table.sectionHeaderHeight = 10
        table.sectionFooterHeight = 10
        table.delegate = self
        return table
    }()
    
    private lazy var scanButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.hex("4680E4")
        b.titleLabel?.font = UIFont.gilroy(.GilroyMedium, size: 18)
        b.setTitle("Scan the network", for: .normal)
        b.setTitleColor(UIColor.hex("FFFFFF"), for: .normal)
        b.layer.cornerRadius = 20
        b.height(56)
        b.addTarget(self, action: #selector(scanNetworkAction), for: .touchUpInside)
        return b
    }()
    
    // MARK: - Properties
    private lazy var dataSource: DataSource = DataSource(tableView: tableView) { [weak self] tableView, indexPath, item in
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AntiSpyDetailsCell", for: indexPath) as? AntiSpyDetailsCell,
           let item = item as? AntiSpyDetailModel {
            cell.imgView.image = item.image
            cell.titleLabel.text = item.title
            cell.subtitleLabel.text = item.subtitle
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    public var obscuraCompletion: (() -> ())?
    public var selectItemsType: SelectType = .all
    
    private var items: [AntiSpyDetailModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItemsForSelectedType()
        setupSubviews_S32HP()
        configureTableView_S32HP()
        prepareData_HSCF()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let layer = CAShapeLayer()
        let pathRef = CGMutablePath()
        let cornerRadius: CGFloat = 24
        let bounds = cell.bounds.insetBy(dx: 0.5, dy: 0.5)
        
        setCornerRadiusForSectionCell(cell: cell, indexPath: indexPath, tableView: tableView, cellY: 0)
        
        pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
        
        layer.path = pathRef
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.blueLabel.cgColor
        
        let testView = UIView(frame: bounds)
        testView.layer.insertSublayer(layer, at: 0)
        testView.backgroundColor = .clear
        
        cell.backgroundView = testView
    }
    
    @objc func scanNetworkAction() {
        obscuraCompletion?()
        navigationController?.popViewController(animated: false)
    }
    
    private func configureItemsForSelectedType() {
        switch selectItemsType {
        case .all: items = AntiSpyDetailModel.items
        case .infraredCamera: items = AntiSpyDetailModel.cameraItem
        case .wirelessObscura: items = AntiSpyDetailModel.obscuraItem
        default: break
        }
    }
    
    private func setupScanButton() {
        view.addSubview(scanButton)
        scanButton.bottomToSuperview(offset: -16, usingSafeArea: true)
        scanButton.leftToSuperview(offset: 20)
        scanButton.rightToSuperview(offset: -20)
    }
    
    private func setupSubviews_S32HP() {
        view.addSubview(tableView)
        tableView.edgesToSuperview(usingSafeArea: false)
        
        if selectItemsType == .wirelessObscura {
            setupScanButton()
        }
    }
    
    private func configureTableView_S32HP() {
        tableView.register(AntiSpyDetailsCell.self, forCellReuseIdentifier: "AntiSpyDetailsCell")
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    private func prepareData_HSCF() {
        dataSource.apply(makeSnapshot(items: items), animatingDifferences: true)
    }
    
    private func makeSnapshot(items: [AntiSpyDetailModel]) -> Snapshot {
        var snapshot = Snapshot()
        items.forEach { item in
            snapshot.appendSections([item])
            snapshot.appendItems([item], toSection: item)
        }
        return snapshot
    }
}

extension AntiSpyDetailsViewController: UITableViewDelegate {
    public func setCornerRadiusForSectionCell(cell: UITableViewCell, indexPath: IndexPath, tableView: UITableView, cellY: CGFloat) {
        let cornerRadius: CGFloat = 24
        let shapeLayer = CAShapeLayer()
        cell.layer.mask = nil
        
        let bezierPath = UIBezierPath(
            roundedRect: cell.bounds.insetBy(dx: 0.0, dy: cellY),
            cornerRadius: cornerRadius
        )
        shapeLayer.path = bezierPath.cgPath
        cell.layer.mask = shapeLayer
    }
}

struct AntiSpyDetailsViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            AntiSpyDetailsViewController()
        }
    }
}
