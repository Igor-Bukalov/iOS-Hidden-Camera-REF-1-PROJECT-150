//
//  AntiSpyViewController.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 06.11.2023.
//

import UIKit
import TinyConstraints
import SwiftUI

class AntiSpyViewController: HSCFBaseViewController, UITableViewDelegate {
    enum Section_anti_spy: Int {
        case detectionHistoryHeader, detectionHistory
    }
    
    enum Action_anti_spy: CaseIterable {
        case cameraObscura, infraredCamera, wirelessObscura, wiredObscura, sleepCamera, other
    }
    
    enum ItemValue: Hashable {
        case header, history(_ history: LanHistory)
    }
    
    enum MenuItem: Int, CaseIterable {
        case cameraObscura
        case infraredCamera
        case wirelessObscura
        case wiredObscura
        case sleepCamera
        case other
        
        var displayImage: String {
            switch self {
            case .cameraObscura: "component-1"
            case .infraredCamera: "component-2"
            case .wirelessObscura: "component-3"
            case .wiredObscura: "component-4"
            case .sleepCamera: "component-5"
            case .other: "component-6"
            }
        }
        
        var displayName: String {
            switch self {
            case .cameraObscura: "Camera obscura"
            case .infraredCamera: "Infrared camera"
            case .wirelessObscura: "Wireless obscura"
            case .wiredObscura: "Wired obscura"
            case .sleepCamera: "Sleep camera"
            case .other: "Other"
            }
        }
    }
    
    typealias DataSource = AntiSpyDiffableDataSource
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section_anti_spy, AnyHashable>
    
    // MARK: - UIProperties
    fileprivate lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .clear
        table.delegate = self
        return table
    }()
    
    private lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MenuItemCollectionViewCell.self, forCellWithReuseIdentifier: "MenuItemCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Properties
    private lazy var dataSource: DataSource = DataSource(tableView: tableView) { [weak self] tableView, indexPath, item in
        guard let strongSelf = self else { return UITableViewCell() }
        
        if let item = item as? ItemValue {
            switch item {
            case .history(let history):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScanDetailLanDeviceCell", for: indexPath) as? ScanDetailLanDeviceCell else { return UITableViewCell() }
                if let d = history.foundDate {
                    cell.titleLabel.text = self?.getCorrectDate(date: d)
                }
                cell.actionTapped = {
                    HSCFAlertView.instance.showAlert_HSCF(title: "Deleting", message: "Are you sure you want to delete?", leftActionTitle: "Cancel", rightActionTitle: "Delete") {
                        
                    } rightAction: {
                        HSCFCoreDataManager.shared.remove_HSCF(id: history.id, entity: .lanHistory)
                        DispatchQueue.main.async {
                            var snapshot = strongSelf.dataSource.snapshot()
                            snapshot.deleteItems([item])
                            strongSelf.dataSource.apply(snapshot, animatingDifferences: true)
                        }
                    }
                }
                cell.subtitleLabel.text = history.wifiIP
                return cell
            case .header:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else { return UITableViewCell() }
                cell.titleLabel.text = "Detection history"
                return cell
            }
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView_HSCF()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareData_HSCF2()
    }
    
    private func configureTableView_HSCF() {
        view.addSubview(tableView)
        tableView.edgesToSuperview(usingSafeArea: true)
        tableView.register(ScanDetailLanDeviceCell.self, forCellReuseIdentifier: "ScanDetailLanDeviceCell")
        tableView.register(HeaderCell.self, forCellReuseIdentifier: "HeaderCell")
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 138))
        headerView.addSubview(menuCollectionView)
        menuCollectionView.edgesToSuperview()
        tableView.tableHeaderView = headerView
    }
    
    private func prepareData_HSCF2() {
        var items: [(Section_anti_spy, [AnyHashable])] = []
        
        if let i = HSCFCoreDataManager.shared.getHistory_HSCF() {
            items.append((Section_anti_spy.detectionHistoryHeader, [ItemValue.header]))
            items.append((Section_anti_spy.detectionHistory, i.reversed().map { ItemValue.history($0) }))
        }
        
        dataSource.apply(makeSnapshot(items: items), animatingDifferences: false)
    }
    
    private func makeSnapshot(items: [(Section_anti_spy, [AnyHashable])]) -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections(items.map { $0.0 })
        items.forEach { section, items in
            snapshot.appendItems(items, toSection: section)
        }
        return snapshot
    }
    
    private func getCorrectDate(date: Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy.MM.dd HH:mm"
        return dateFormatterGet.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = dataSource.itemIdentifier(for: indexPath) as? ItemValue {
            switch item {
            case .history(let history):
                guard let vc = Controller_HSCF.scanDetails.controller as? ScanDetailsViewController, let objects = history.devices?.allObjects as? [FoundLanDevice] else { return }
                vc.peripheralItems = objects.map { LanModel(name: $0.name ?? .na, ipAddress: $0.ipAddress ?? .na, mac: $0.macAddress, brand: $0.brand) }
                vc.routerInfo = (history.wifiName ?? .na, history.wifiIP ?? .na, history.wifiInterface)
                navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        }
    }
    
    class AntiSpyDiffableDataSource: UITableViewDiffableDataSource<AntiSpyViewController.Section_anti_spy, AnyHashable> {
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            if let item = itemIdentifier(for: indexPath) as? ItemValue {
                switch item {
                case .history: true
                case .header: false
                }
            } else {
                false
            }
        }
    }
}

extension AntiSpyViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 98)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return section == 0 ? UIEdgeInsets(top: 15, left: 20, bottom: 25, right: 20) : UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCollectionViewCell", for: indexPath) as? MenuItemCollectionViewCell else {
            fatalError("Cannot create new cell")
        }
        
        let menuItem = MenuItem(rawValue: indexPath.item)
        cell.configure(with: menuItem?.displayName ?? "", image: UIImage(named: menuItem?.displayImage ?? ""))
        cell.layer.cornerRadius = 24
        cell.layer.borderWidth = 0.6
        cell.layer.borderColor = UIColor.blueLabel.cgColor
        cell.backgroundColor = UIColor.cellBackground
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action = Action_anti_spy.allCases[indexPath.row]
        let detailViewController = Controller_HSCF.antiSpyDetail.controller as! AntiSpyDetailsViewController
        
        switch action {
        case .cameraObscura:
            detailViewController.selectItemsType = .all
        case .infraredCamera:
            detailViewController.selectItemsType = .infraredCamera
        case .wirelessObscura:
            detailViewController.selectItemsType = .wirelessObscura
            detailViewController.obscuraCompletion = {
                menuController?.processOpeningScanSceneAndScanning()
            }
        case .wiredObscura:
            detailViewController.selectItemsType = .all
        case .sleepCamera:
            detailViewController.selectItemsType = .all
        case .other:
            detailViewController.selectItemsType = .all
        }
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

struct AntiSpyViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            AntiSpyViewController()
        }
    }
}
