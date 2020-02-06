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
	
	private let feedSceneView = FeedSceneView()
	private let titleView = TitleView()
	private var feedViewModel = FeedViewModel(cells: [])
	private var refreshControl: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
		return refreshControl
	}()
	
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
	
	// MARK: View lifecycle
	override func loadView() {
		self.view = feedSceneView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		setupNavigationBar()
		setupTableView()
		interactor?.makeRequest(request: .getNewsFeed)
		interactor?.makeRequest(request: .getUser)
	}
	
	@objc private func refresh() {
		interactor?.makeRequest(request: .getNewsFeed)
	}
	
	private func setupTableView() {
		self.feedSceneView.tableView.contentInset.top = 8
		self.feedSceneView.tableView.delegate = self
		self.feedSceneView.tableView.dataSource = self
		self.feedSceneView.tableView.separatorStyle = .none
		self.feedSceneView.tableView.backgroundColor = .clear
		self.feedSceneView.backgroundColor = Colors.mainStyle
		self.feedSceneView.tableView.register(UINib(nibName: "NewsFeedCell", bundle: nil),
											  forCellReuseIdentifier: NewsFeedCell.reuseId)
		self.feedSceneView.tableView.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseId)
		self.feedSceneView.tableView.addSubview(refreshControl)
	}
	
	private func setupNavigationBar() {
		self.navigationController?.hidesBarsOnSwipe = true
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationItem.titleView = titleView
	}
	
	func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
		switch viewModel {
		case .displayNewsFeed(let feedViewModel):
			self.feedViewModel = feedViewModel
			self.feedSceneView.tableView.reloadData()
			refreshControl.endRefreshing()
		case .displayUserInfo(let userInfo):
			titleView.set(userViewModel: userInfo)
		}
	}
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
			interactor?.makeRequest(request: .getNextBatch)
			
			
			
		}
	}
}

extension NewsFeedViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return feedViewModel.cells.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseId, for: indexPath)
			as? NewsFeedCodeCell else { return UITableViewCell(style: .default, reuseIdentifier: "cell") }
		let cellViewModel = feedViewModel.cells[indexPath.row]
		cell.set(viewModel: cellViewModel)
		cell.delegate = self
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let cellViewModel = feedViewModel.cells[indexPath.row]
		return cellViewModel.sizes.totalHeight
	}
}

extension NewsFeedViewController: UITableViewDelegate {
}

extension NewsFeedViewController: NewsFeedCodeCellDelegate {
	func revelPost(for cell: NewsFeedCodeCell) {
		guard let indexPath = feedSceneView.tableView.indexPath(for: cell) else { return }
		let cellViewModel = feedViewModel.cells[indexPath.row]
		interactor?.makeRequest(request: .revealPostIds(postId: cellViewModel.postId))
	}
}

