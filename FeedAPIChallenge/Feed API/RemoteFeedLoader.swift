//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import Foundation

public final class RemoteFeedLoader: FeedLoader {
	private let url: URL
	private let client: HTTPClient

	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}

	public typealias Result = FeedLoader.Result

	public init(url: URL, client: HTTPClient) {
		self.url = url
		self.client = client
	}

	public func load(completion: @escaping (FeedLoader.Result) -> Void) {
		// self [weak self] for memory leak, then the RemoteFeedLoad died at running
		client.get(from: url, completion: { [weak self] result in
			guard self != nil else { return }
			switch result {
			case let .success((data, response)):
				completion(FeedImageItemMapper.map(data, response: response))
			case .failure:
				completion(.failure(Error.connectivity))
			}
		})
	}
}
