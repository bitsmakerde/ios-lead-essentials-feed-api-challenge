//
//  FeedImageMapper.swift
//  FeedAPIChallenge
//
//  Created by André Bongartz on 09.09.21.
//  Copyright © 2021 Essential Developer Ltd. All rights reserved.
//

import Foundation

internal enum FeedImageItemMapper {
	struct Root: Decodable {
		let items: [Item]

		var feedImages: [FeedImage] {
			return items.map { $0.item }
		}
	}

	struct Item: Decodable {
		var image_id: UUID
		var image_desc: String?
		var image_loc: String?
		var image_url: URL

		var item: FeedImage {
			return FeedImage(id: image_id, description: image_desc, location: image_loc, url: image_url)
		}
	}

//	func map(data: Data) -> [FeedImage] {
//
//		return []
//	}
}
