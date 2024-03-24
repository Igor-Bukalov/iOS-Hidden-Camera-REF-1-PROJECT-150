//
//  TutorialViewController.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 13.11.2023.
//

import UIKit
import TinyConstraints
import SwiftUI

class HSCFTutorialViewController: HSCFBaseViewController {
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
    
    // MARK: - Properties
    private var items: [TutorialModel] = []
    
    private lazy var dataSource: DataSource = DataSource(tableView: tableView) { [weak self] tableView, indexPath, item in
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TutorialCell", for: indexPath) as? TutorialCell,
           let item = item as? TutorialModel {
            cell.configure(with: item)
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        items = TutorialModel.item
        setupTableView()
        applySnapshot()
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
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.edgesToSuperview(usingSafeArea: false)
        tableView.register(TutorialCell.self, forCellReuseIdentifier: "TutorialCell")
        tableView.dataSource = dataSource
    }
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension HSCFTutorialViewController: UITableViewDelegate {
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

struct HSCFTutorialViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            HSCFTutorialViewController()
        }
    }
}
