//
//  NewsFeedViewController.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 31.01.2020.
//  Copyright (c) 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: class {
	func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {
	
	var interactor: NewsFeedBusinessLogic?
	var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
	let feedSceneView = FeedSceneView()
	
	
	// MARK: Setup
	private func setup() {
		let viewController        = self
		let interactor            = NewsFeedInteractor()
		let presenter             = NewsFeedPresenter()
		let router                = NewsFeedRouter()
		viewController.interactor = interactor
		viewController.router     = router
		interactor.presenter      = presenter
		presenter.viewController  = viewController
		router.viewController     = viewController
	}
	
	// MARK: Routing
	
	
	
	// MARK: View lifecycle
	override func loadView() {
		self.view = feedSceneView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.feedSceneView.tableView.delegate = self
		self.feedSceneView.tableView.dataSource = self
		setup()
	}
	
	func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
		switch viewModel {
		case .some:
			print(".some viewController")
		case .displayNewsFeed:
			print(".displayNewsFeed viewController")
		}
	}
}

extension NewsFeedViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
			?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
		
		cell.textLabel?.text = "section = \(indexPath.section), row = \(indexPath.row)"
		cell.detailTextLabel?.text = "detailTextLabel"
		return cell
	}
}

extension NewsFeedViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		interactor?.makeRequest(request: .getFeed)
	}
}
