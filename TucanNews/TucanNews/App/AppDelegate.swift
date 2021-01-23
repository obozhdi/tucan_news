//
//  AppDelegate.swift
//  TucanNews
//
//  Created by Artem Pashkov on 22.01.2021.
//

import UIKit
@_exported import RambaHamba

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .black
    window?.rootViewController = UINavigationController(rootViewController: NewsListController())
    window?.makeKeyAndVisible()
    
    return true
  }

}
