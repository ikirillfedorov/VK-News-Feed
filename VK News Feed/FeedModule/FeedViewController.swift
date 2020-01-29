//
//  FeedViewController.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 26.01.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
	
	private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		networkService.getFeed()
    }
}
