//
//  NewsFeedInteractor.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 31.01.2020.
//  Copyright (c) 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
	func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {
	
	var presenter: NewsFeedPresentationLogic?
	var service: NewsFeedService?
	
	func makeRequest(request: NewsFeed.Model.Request.RequestType) {
		if service == nil {
			service = NewsFeedService()
		}
		
		switch request {
		case .some:
			print(".some interactor")
		case .getFeed:
			print(".getFeed interactor")
			presenter?.presentData(response: .presentNewsFeed)
		}
	}
}
