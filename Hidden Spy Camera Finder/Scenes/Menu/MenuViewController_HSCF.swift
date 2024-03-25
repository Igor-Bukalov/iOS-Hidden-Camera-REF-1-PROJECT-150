//
//  MenuViewController.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 06.11.2023.
//

import UIKit
import TinyConstraints
import SwiftUI

var menuView: UIView!
var menuController: GSDA_ContainerForMenuController_GSD?

final class HTSP_MenuItem_View: UIView {
    lazy var buttonAction: UIButton = {
        let button = UIButton()
        button.setTitle(nil, for: .normal)
        button.width(isiPad ? 134 : 80)
        button.aspectRatio(1)
        button.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        return button
    }()
    lazy var menuImage: UIImageView = {
        let imgView = UIImageView()
        imgView.width(isiPad ? 67 : 40)
        imgView.aspectRatio(1)
        imgView.tintColor = UIColor.white.withAlphaComponent(0.7)
        imgView.layer.opacity = 0.7
        return imgView
    }()
    lazy var menuTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.gilroy(.GilroySemibold, size: isiPad ? 20 : 12)
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        return label
    }()
    lazy var shadowImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "tab-shadow")
        imgView.width(isiPad ? 134 : 80)
        imgView.aspectRatio(1)
        imgView.isHidden = true
        return imgView
    }()
    
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    var actionCompletion: (() -> Void)?
    var controller: MenuController?
    
    init(controller: MenuController) {
        super.init(frame: .zero)
        self.controller = controller
        setupSubviews()
        menuImage.image = controller.icon
        menuTitle.text = controller.menuTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isSelect(_ isSelect: Bool) {
        menuImage.layer.opacity = isSelect ? 1.0 : 0.7
        menuImage.tintColor = isSelect ? UIColor.blueLabel : UIColor.white.withAlphaComponent(0.7)
        menuTitle.textColor = isSelect ? UIColor.blueLabel : UIColor.white.withAlphaComponent(0.7)
        shadowImageView.isHidden = !isSelect
    }
    
    private func setupSubviews() {
        menuTitle.text = "asde"
        
        addSubview(shadowImageView)
        shadowImageView.centerInSuperview()
        
        addSubview(menuImage)
        menuImage.centerXToSuperview()
        menuImage.centerYToSuperview(offset: isiPad ? -10 : -5)
        
        addSubview(menuTitle)
        menuTitle.topToBottom(of: menuImage, offset: isiPad ? 8 : 4)
        menuTitle.centerXToSuperview()
        
        addSubview(buttonAction)
        buttonAction.edgesToSuperview()
    }
    
    @objc
    func actionTapped() {
        actionCompletion?()
    }
}

final class GSDA_ContainerForMenuController_GSD: UIViewController {
    private lazy var menuViewController = MenuViewController()
    private let containerView = UIView()
    private lazy var menuContainer: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.height(isiPad ? 460 : 274)
        return view
    }()
    
    private var tabbarMenuView: UIView = UIView()
    
    private var scan: HTSP_MenuItem_View = HTSP_MenuItem_View(controller: .scan)
    private var antiSpy: HTSP_MenuItem_View = HTSP_MenuItem_View(controller: .antiSpy)
    private var btRadar: HTSP_MenuItem_View = HTSP_MenuItem_View(controller: .btRadar)
    private var settings: HTSP_MenuItem_View = HTSP_MenuItem_View(controller: .settings)
    
    private let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuController = self
        setupSubviews()
        scan.actionCompletion = { [weak self] in
            self?.actionTapped(controller: .scan)
            self?.menuTitle.text = "Scanning"
        }
        antiSpy.actionCompletion = { [weak self] in
            self?.actionTapped(controller: .antiSpy)
            self?.menuTitle.text = "Anti-spy"
        }
        btRadar.actionCompletion = { [weak self] in
            self?.actionTapped(controller: .btRadar)
            self?.menuTitle.text = "Bluetooth"
        }
        settings.actionCompletion = { [weak self] in
            self?.actionTapped(controller: .settings)
            self?.menuTitle.text = "Settings"
        }
        scan.isSelect(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        menuView.isHidden = true
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
            let vc: HSCFScanViewController? = self?.menuViewController.getViewController(controller: .scan)
            vc?.tryStartScan()
        }
    }
    
    lazy var backgroundMenuView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "menu-ellipse"))
        return view
    }()
    
    lazy var menuTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.gilroy(.GilroySemibold, size: isiPad ? 33 : 20)
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var closeMenuButton: UIButton = {
        let button = UIButton()
        button.setTitle(nil, for: .normal)
        button.setImage(UIImage(named: "close-menu-button"), for: .normal)
        button.width(isiPad ? 53 : 32)
        button.height(isiPad ? 53 : 32)
        button.imageView?.width(isiPad ? 53 : 32)
        button.imageView?.height(isiPad ? 53 : 32)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return button
    }()
    
    @objc
    func closeAction() {
        UIView.animate(withDuration: 0.25, animations: {
            menuView.transform = CGAffineTransform(translationX: 0, y: -menuView.frame.height)
        }) { _ in
            menuView.isHidden = true
        }
    }
    
    private func setupSubviews() {
        menuTitle.text = "Scanning"
        
        // Main app view
        view.addSubview(containerView)
        containerView.edgesToSuperview()
        
        // Ellipse background
        menuContainer.addSubview(backgroundMenuView)
        backgroundMenuView.edgesToSuperview()
        
        // Menu buttons container
        menuContainer.addSubview(tabbarMenuView)
        tabbarMenuView.edgesToSuperview()
        
        // Close button
        menuContainer.addSubview(closeMenuButton)
        closeMenuButton.bottomToSuperview(offset: isiPad ? -26 : -16)
        closeMenuButton.centerXToSuperview()
        
        menuContainer.addSubview(menuTitle)
        menuTitle.topToSuperview(offset: isiPad ? 28 : 12, usingSafeArea: true)
        menuTitle.centerXToSuperview()
        
        // Background and buttons container
        view.addSubview(menuContainer)
        menuContainer.topToSuperview(offset: -10, usingSafeArea: false)
        menuContainer.leftToSuperview()
        menuContainer.rightToSuperview()
        
        addChild(menuViewController)
        containerView.addSubview(menuViewController.view)
        menuViewController.view.edgesToSuperview()
        
        let buttonsStackView = UIStackView(arrangedSubviews: [scan, antiSpy, btRadar, settings])
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        
        tabbarMenuView.addSubview(buttonsStackView)
        buttonsStackView.width(isiPad ? 536 : 320)
        buttonsStackView.centerXToSuperview()
        buttonsStackView.centerY(to: backgroundMenuView, offset: 10)
        
        menuView = menuContainer
    }
    
    private func actionTapped(controller: MenuController) {
        // MARK: Original code
        switch controller {
        case .scan:
            menuViewController.selectTab(controller: .scan)
        case .antiSpy:
            menuViewController.selectTab(controller: .antiSpy)
        case .btRadar:
            menuViewController.selectTab(controller: .btRadar)
        case .settings:
            menuViewController.selectTab(controller: .settings)
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
        viewControllers = MenuController.allCases.map { $0.controllerWithNavigation }
        selectTab(controller: .scan)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public func selectTab(controller: MenuController) {
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
    
    public func getViewController<T>(controller: MenuController) -> T? {
        let navController = viewControllers[controller.rawValue] as? UINavigationController
        return navController?.viewControllers.first as? T
    }
}

struct GSDA_ContainerForMenuController_GSD_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            InitialViewController()
        }
    }
}
