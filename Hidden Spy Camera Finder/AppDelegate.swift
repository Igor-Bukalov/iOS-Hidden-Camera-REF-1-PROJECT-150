//
//  AppDelegate.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 06.11.2023.
//

import UIKit
import CoreData
import Pushwoosh
import Adjust
import AVFoundation
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        HSCFNetworkMonitor.shared.startMonitoring_HSCF()
        
        window = UIWindow()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting up AVAudioSession: \(error.localizedDescription)")
        }
        
        ThirdPartyServicesManager.shared.initializeAdjust_HSCF()
        ThirdPartyServicesManager.shared.initializeInApps_HSCF()
        ThirdPartyServicesManager.shared.initializePushwooshHSCF(delegate: self) {}
        
        prepareAppearence()
        
        let loadingController = LoadingViewController()
        loadingController.onLoadingComplete = { [weak self] in
            self?.showMenuController()
        }
        self.window?.rootViewController = loadingController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func showMenuController() {
        DispatchQueue.main.async {
            let mainController = GSDA_ContainerForMenuController_GSD()
            self.window?.rootViewController = mainController
        }
    }
    
    private func prepareAppearence() {
        let isiPad = UIDevice.current.userInterfaceIdiom == .pad
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor.customBackground
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.customDarkBlue, .font: UIFont.gilroy(.semibold, size: isiPad ? 33 : 20)]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.customDarkBlue]
        
        UINavigationBar.appearance().tintColor = .customDarkBlue
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        UINavigationBar.appearance().backIndicatorImage = UIImage()
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage()
        
        UIViewController.classInit
    }
}

typealias SO_APP_DEL_GAT_HSCF = AppDelegate

extension SO_APP_DEL_GAT_HSCF : PWMessagingDelegate, UITableViewDelegate {
    //handle token received from APNS
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Adjust.setDeviceToken(deviceToken)
        Pushwoosh.sharedInstance().handlePushRegistration(deviceToken)
    }
    
    //handle token receiving error
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Pushwoosh.sharedInstance().handlePushRegistrationFailure(error);
    }
    
    //this is for iOS < 10 and for silent push notifications
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Pushwoosh.sharedInstance().handlePushReceived(userInfo)
        completionHandler(.noData)
    }
    
    //this event is fired when the push gets received
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageReceived message: PWMessage) {
        print("onMessageReceived: ", message.payload?.description ?? "error")
    }
    
    //this event is fired when a user taps the notification
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageOpened message: PWMessage) {
        print("onMessageOpened: ", message.payload?.description ?? "error")
    }
}

struct AppDelegate_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            GSDA_ContainerForMenuController_GSD()
        }
    }
}

struct ViewControllerPreview: UIViewControllerRepresentable {
    var viewControllerBuilder: () -> UIViewController
    
    init(_ viewControllerBuilder: @escaping () -> UIViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        viewControllerBuilder()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
