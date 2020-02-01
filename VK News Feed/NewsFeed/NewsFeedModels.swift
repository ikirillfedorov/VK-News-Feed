//
//  NewsFeedModels.swift
//  VK News Feed
//
//  Created by Kirill Fedorov on 31.01.2020.
//  Copyright (c) 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

enum NewsFeed {
   
  enum Model {
    struct Request {
      enum RequestType {
		case getNewsFeed
      }
    }
    struct Response {
      enum ResponseType {
		case presentNewsFeed(feed: FeedResponse)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsFeed(feedViewModel: FeedViewModel)
      }
    }
  }
}

struct FeedViewModel {
	struct Cell: FeedCellViewModel {
		var iconUrlString: String
		var name: String
		var date: String
		var text: String?
		var likes: String?
		var comments: String?
		var shares: String?
		var views: String?
	}
	let cells: [Cell]
}
