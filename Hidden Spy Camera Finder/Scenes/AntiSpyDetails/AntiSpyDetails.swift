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
        case obscura
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        setCornerRadiusForSectionCell(cell: cell, indexPath: indexPath, tableView: tableView, cellY: 0)
        
        let cornerRadius: CGFloat = 24
        let layer = CAShapeLayer()
        let pathRef = CGMutablePath()
        let bounds = cell.bounds.insetBy(dx: 0.6, dy: 0.6)
        
        pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
        
        layer.path = pathRef
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.blueLabel.cgColor
        
        let testView = UIView(frame: bounds)
        testView.layer.insertSublayer(layer, at: 0)
        testView.backgroundColor = .clear
        
        cell.backgroundView = testView
    }
    
    // MARK: - Properties
    private lazy var dataSource: DataSource = DataSource(tableView: tableView) { [weak self] tableView, indexPath, item in
        if
            let cell = tableView.dequeueReusableCell(withIdentifier: "AntiSpyDetailsCell", for: indexPath) as? AntiSpyDetailsCell,
            let item = item as? AntiSpyDetailModel {
            cell.imgView.image = item.image
            cell.titleLabel.text = item.title
            cell.subtitleLabel.text = item.subtitle
            cell.selectionStyle = .none
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "AntiSpyButtonCell", for: indexPath) as? AntiSpyButtonCell, let item = item as? Int {
            cell.actionCompletion = { [weak self] in
                self?.obscuraCompletion?()
                self?.navigationController?.popViewController(animated: false)
            }
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
        items = selectItemsType == .all ? AntiSpyDetailModel.items : AntiSpyDetailModel.item
        setupSubviews_S32HP()
        configureTableView_S32HP()
        prepareData_HSCF()
    }
    
    private func setupSubviews_S32HP() {
        view.addSubview(tableView)
        tableView.edgesToSuperview(usingSafeArea: true)
    }
    
    private func configureTableView_S32HP() {
        view.addSubview(tableView)
        tableView.edgesToSuperview()
        tableView.register(AntiSpyDetailsCell.self, forCellReuseIdentifier: "AntiSpyDetailsCell")
        tableView.register(AntiSpyButtonCell.self, forCellReuseIdentifier: "AntiSpyButtonCell")
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
        if selectItemsType == .obscura {
            snapshot.appendSections([selectItemsType])
            snapshot.appendItems([1])
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
