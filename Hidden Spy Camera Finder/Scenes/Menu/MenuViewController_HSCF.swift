//
//  MenuViewController.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 06.11.2023.
//

import UIKit
import TinyConstraints
import SwiftUI

var tabbarView: UIView!
var tabController: GSDA_ContainerForMenuController_GSD?

final class HTSP_MenuItem_View: UIView {
    lazy var buttonAction: UIButton = {
        let button = UIButton()
        button.setTitle(nil, for: .normal)
        button.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        return button
    }()
    lazy var menuImage: UIImageView = {
        let imgView = UIImageView()
        imgView.tintColor = .yellow
        imgView.layer.opacity = 0.7
        return imgView
    }()
    lazy var menuTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.gilroy(.GilroySemibold, size: 12)
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        return label
    }()
    lazy var shadowImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "tab-shadow")
        imgView.isHidden = true
        return imgView
    }()
    
    var actionCompletion: (() -> Void)?
    var controller: TabController?
    
    init(controller: TabController) {
        super.init(frame: .zero)
        self.controller = controller
        setupSubviews()
        menuTitle.text = controller.tabbarTitle
        menuImage.image = controller.icon
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isSelect(_ isSelect: Bool) {
        menuImage.layer.opacity = isSelect ? 1.0 : 0.7
        menuTitle.textColor = isSelect ? UIColor.blueLabel : UIColor.white.withAlphaComponent(0.7)
        shadowImageView.isHidden = !isSelect
    }
    
    private func setupSubviews() {
        menuTitle.text = "asde"
        
        addSubview(shadowImageView)
        shadowImageView.width(80)
        shadowImageView.height(80)
        
        let stackView = UIStackView(arrangedSubviews: [menuImage, menuTitle])
        stackView.axis = .vertical
        stackView.spacing = 4
        addSubview(stackView)
        
        stackView.centerXToSuperview()
        stackView.centerYToSuperview()

        menuImage.aspectRatio(1)
        
        shadowImageView.centerY(to: stackView)
        shadowImageView.centerX(to: stackView)
        
        addSubview(buttonAction)
        buttonAction.edgesToSuperview()
    }
    
    @objc
    func actionTapped() {
        actionCompletion?()
    }
}

final class GSDA_ContainerForMenuController_GSD: UIViewController {
    private lazy var menuController = MenuViewController()
    private let containerView = UIView()
    private let tabbarMenuContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tabbarBackground
        return view
    }()
    
    private var tabbarMenuView: UIView = UIView()
    
    private var scan: HTSP_MenuItem_View = HTSP_MenuItem_View(controller: .scan)
    private var antiSpy: HTSP_MenuItem_View = HTSP_MenuItem_View(controller: .antiSpy)
    private var btRadar: HTSP_MenuItem_View = HTSP_MenuItem_View(controller: .btRadar)
    private var settings: HTSP_MenuItem_View = HTSP_MenuItem_View(controller: .settings)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabController = self
        setupSubviews()
        scan.actionCompletion = { [weak self] in self?.actionTapped(controller: .scan) }
        antiSpy.actionCompletion = { [weak self] in self?.actionTapped(controller: .antiSpy) }
        btRadar.actionCompletion = { [weak self] in self?.actionTapped(controller: .btRadar) }
        settings.actionCompletion = { [weak self] in self?.actionTapped(controller: .settings) }
        scan.isSelect(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        menuController.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !UserDefaults.termsOfServiceAlertIsShowed {
            HSCFAlertView.instance.showAlert_HSCF(title: "Terms of Service and Privacy Policy", message: "Welcome! We are dedicated to ensuring the privacy of your information. Our Terms of Service and Privacy Policy offer detailed information on data collection and usage. By clicking ‘Accept’ below, you affirm your consent to our Terms of Service and understanding of the Privacy Policy.", leftActionTitle: "Accept", rightActionTitle: nil) {
                UserDefaults.termsOfServiceAlertIsShowed = true
            } rightAction: {
                
            }
        }
    }
    
    public func processOpeningScanSceneAndScanning() {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.actionTapped(controller: .scan)
            let vc: HSCFScanViewController? = self?.menuController.getViewController(controller: .scan)
            vc?.tryStartScan()
        }
    }
    
    private let backgroundMenuView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "menu-ellipse"))
        return view
    }()
    
    private let closeMenuButton: UIImageView = {
        let view = UIImageView(image: UIImage(named: "close-menu-button"))
        return view
    }()
    
    private func setupSubviews() {
        let mainStackView = UIStackView(arrangedSubviews: [containerView, tabbarMenuContainer])
        mainStackView.axis = .vertical
        view.addSubview(mainStackView)
        mainStackView.edgesToSuperview()
        
        tabbarMenuContainer.addSubview(tabbarMenuView)
        tabbarMenuView.topToSuperview()
        tabbarMenuView.bottomToSuperview(usingSafeArea: true)
        tabbarMenuView.leftToSuperview()
        tabbarMenuView.rightToSuperview()
        tabbarMenuView.height(64)
        
        addChild(menuController)
        containerView.addSubview(menuController.view)
        menuController.view.edgesToSuperview()
        
        let stackView = UIStackView(arrangedSubviews: [scan, antiSpy, btRadar, settings])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        tabbarMenuView.addSubview(stackView)
        stackView.leftToSuperview()
        stackView.rightToSuperview()
        stackView.centerYToSuperview()
        
        tabbarView = tabbarMenuContainer
    }
    
    private func actionTapped(controller: TabController) {
        // MARK: Original code
        switch controller {
        case .scan:
            menuController.selectTab(controller: .scan)
        case .antiSpy:
            menuController.selectTab(controller: .antiSpy)
        case .btRadar:
            menuController.selectTab(controller: .btRadar)
        case .settings:
            menuController.selectTab(controller: .settings)
        }
        
        scan.isSelect(controller == .scan)
        antiSpy.isSelect(controller == .antiSpy)
        btRadar.isSelect(controller == .btRadar)
        settings.isSelect(controller == .settings)
    }
}

class MenuViewController: UIViewController {
    private var viewControllers: [UIViewController] = []
    private var selectedViewController: UIViewController?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = TabController.allCases.map { $0.controllerWithNavigation }
        selectTab(controller: .scan)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public func selectTab(controller: TabController) {
        selectedViewController?.willMove(toParent: nil)
        selectedViewController?.view.removeFromSuperview()
        selectedViewController?.removeFromParent()
        
        let newController = viewControllers[controller.rawValue]
        addChild(newController)
        view.addSubview(newController.view)
        newController.view.edgesToSuperview()
        newController.didMove(toParent: self)
        selectedViewController = newController
    }
    
    public func getViewController<T>(controller: TabController) -> T? {
        let navController = viewControllers[controller.rawValue] as? UINavigationController
        return navController?.viewControllers.first as? T
    }
}

struct GSDA_ContainerForTabbarController_GSD_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            InitialViewController()
        }
    }
}

//// MARK: Menu View
//let stackView = UIStackView(arrangedSubviews: [scan, antiSpy, btRadar, settings])
//stackView.axis = .horizontal
//stackView.spacing = 4
//stackView.distribution = .fillEqually
//
//backgroundMenuView.addSubview(closeMenuButton)
//closeMenuButton.centerXToSuperview()
//closeMenuButton.bottomToSuperview(offset: -16)
//closeMenuButton.height(32)
//
//backgroundMenuView.addSubview(stackView)
//stackView.leftToSuperview(offset: 20)
//stackView.rightToSuperview(offset: -20)
//stackView.bottomToTop(of: closeMenuButton, offset: -55)
//
//view.addSubview(backgroundMenuView)
//backgroundMenuView.topToSuperview(usingSafeArea: false)
//backgroundMenuView.leftToSuperview()
//backgroundMenuView.rightToSuperview()
//
//tabbarView = tabbarMenuContainer
