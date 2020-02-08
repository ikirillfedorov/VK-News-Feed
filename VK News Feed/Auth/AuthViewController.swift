//
//  AuthViewController.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 26.01.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
	
	private let signInButton = UIButton()

	var authService: AuthService?

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .white
		setupSubView()
		setContraints()
    }
	
	override func viewDidLayoutSubviews() {
		signInButton.layer.cornerRadius = signInButton.frame.height / 5
	}
	
	private func setupSubView() {
		self.view.addSubview(signInButton)
		setupEntryButton()
		self.authService = AppDelegate.shared().authService
	}
	
	private func setupEntryButton() {
		signInButton.backgroundColor = Colors.mainStyle
		signInButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
		signInButton.setTitle("Войти в VK", for: .normal)
		signInButton.setTitleColor(.black, for: .highlighted)
		signInButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 24)
		signInButton.addTarget(self, action: #selector(entryButtonPressed), for: .touchUpInside)
	}

	@objc private func entryButtonPressed() {
		authService?.wakeUpSession()
	}
	
	private func setContraints() {
		signInButton.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			signInButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
		])
	}
}
