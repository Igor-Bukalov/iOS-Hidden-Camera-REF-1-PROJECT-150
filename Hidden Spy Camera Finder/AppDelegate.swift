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
        let initial = InitialViewController()
        self.window?.rootViewController = initial
        self.window?.makeKeyAndVisible()
        return true
    }
    
    private func prepareAppearence() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor.navigationBackground
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.blueLabel, .font: UIFont.gilroy(.GilroySemibold, size: 20)]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.blueLabel]
        
        UINavigationBar.appearance().tintColor = .blueLabel
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        UINavigationBar.appearance().backIndicatorImage = UIImage()
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage()
        
//        let tabbarAppearance = UITabBarAppearance()
//        tabbarAppearance.backgroundColor = UIColor.tabbarBackground
//        UITabBar.appearance().standardAppearance = tabbarAppearance
//        UITabBar.appearance().scrollEdgeAppearance = tabbarAppearance
        
//        tabbarAppearenceSettings(tabbarAppearance.stackedLayoutAppearance)
//        tabbarAppearenceSettings(tabbarAppearance.inlineLayoutAppearance)
//        tabbarAppearenceSettings(tabbarAppearance.compactInlineLayoutAppearance)
        
        UIViewController.classInit
    }
    
//    private func tabbarAppearenceSettings(_ itemAppearance: UITabBarItemAppearance) {
//        itemAppearance.normal.iconColor = UIColor.tabbarItem
//        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.tabbarItem]
//        
//        itemAppearance.selected.iconColor = UIColor.tabbarItemSelected
//        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.tabbarItemSelected]
//    }
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
            InitialViewController()
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
