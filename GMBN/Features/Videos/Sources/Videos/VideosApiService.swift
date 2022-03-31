import Foundation
import ComposableArchitecture

// Here we declare an api that we will want anyone using Videos feature to conform to

public protocol VideosApiService {
	func requestVideos() -> Effect<[Video], Error>
}

public class VideosApiServiceMock: VideosApiService {
	public var _requestVideos: () -> Effect<[Video], Error> = {
		Effect(value: [])
	}

	public func requestVideos() -> Effect<[Video], Error> {
		_requestVideos()
	}
}
