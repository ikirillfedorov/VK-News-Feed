//
//  AuthService.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 26.01.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: class {
	func authServiceShouldShow(_ viewController: UIViewController)
	func authServiceSignIn()
	func authServiceDidSignInFail()
}

final class AuthService: NSObject {
	
	private let appId = "7295660"
	private let vkSdk: VKSdk
	
	weak var delegate: AuthServiceDelegate?
	var token: String? {
		return VKSdk.accessToken()?.accessToken
	}
	
	override init() {
		vkSdk = VKSdk.initialize(withAppId: appId)
		super.init()
		vkSdk.register(self)
		vkSdk.uiDelegate = self
	}
	
	func wakeUpSession() {
		let scope = ["offline", "photos", "wall", "friends"]
		VKSdk.wakeUpSession(scope) { [delegate] state, error in
			switch state {
			case .authorized:
				delegate?.authServiceSignIn()
			case .initialized:
				VKSdk.authorize(scope)
			default:
				print("error \(error?.localizedDescription)")
				delegate?.authServiceDidSignInFail()
			}
		}
	}
}

extension AuthService: VKSdkDelegate {
	func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
		guard result.token != nil else { return }
		delegate?.authServiceSignIn()
	}
	
	func vkSdkUserAuthorizationFailed() {
		print(#function)
	}
}

extension AuthService: VKSdkUIDelegate {
	func vkSdkShouldPresent(_ controller: UIViewController!) {
		delegate?.authServiceShouldShow(controller)
	}
	
	func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
		print(#function)
	}
}
