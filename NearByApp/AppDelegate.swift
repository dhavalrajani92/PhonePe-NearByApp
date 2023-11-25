//
//  AppDelegate.swift
//  NearByApp
//
//  Created by Dhaval Rajani on 11/25/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  private lazy var navController: UINavigationController = UINavigationController(navigationBarClass: nil, toolbarClass: nil)

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    window = UIWindow(frame: UIScreen.main.bounds)
    let _ = NearByAppFlowContainer(navController: navController, viewModel: NearByAppFlowViewModel(networkEngine: NetworkEngine()))
    window?.rootViewController = navController
    window?.makeKeyAndVisible()
    return true
  }
}

