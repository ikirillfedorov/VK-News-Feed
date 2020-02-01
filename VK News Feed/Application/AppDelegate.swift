//
//  AppDelegate.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 26.01.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit
import VKSdkFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	let authService = AuthService()
	
	static func shared() -> AppDelegate {
		return UIApplication.shared.delegate as! AppDelegate
	}

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		authService.delegate = self
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = AuthViewController()
		self.window?.makeKeyAndVisible()
		return true
	}
	
	func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
		VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
		return true
	}
}

extension AppDelegate: AuthServiceDelegate {
	func authServiceShouldShow(_ viewController: UIViewController) {
		window?.rootViewController?.present(viewController, animated: true, completion: nil)
	}
	
	func authServiceSignIn() {
		let feedVC = NewsFeedViewController()
		let navigationVC = UINavigationController(rootViewController: feedVC)
		window?.rootViewController = navigationVC
	}
	
	func authServiceDidSignInFail() {
		print(#function)
	}
}

