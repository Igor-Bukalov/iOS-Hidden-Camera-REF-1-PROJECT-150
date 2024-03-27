//
//  TutorialViewController.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 13.11.2023.
//

import UIKit
import TinyConstraints
import SwiftUI

class TutorialViewController: HSCFBaseViewController {
    typealias DataSource = UITableViewDiffableDataSource<AnyHashable, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<AnyHashable, AnyHashable>
    
    // MARK: - UIProperties
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.backgroundColor = .clear
        table.sectionHeaderHeight = 10
        table.sectionFooterHeight = 10
        return table
    }()
    
    // MARK: - Properties
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
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

struct TutorialViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            TutorialViewController()
        }
    }
}
