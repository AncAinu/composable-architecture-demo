import Foundation
import ComposableArchitecture

// Please note that the composable architecture is so light and composable in it's ability to do small modules, that file organisation inside modules is less relevant and allow for less care around that, but of course it can all be separated in files when it gets more complex, although the idea with TCA would be to do more modules

public struct Video {
	let name: String
	let description: String
	let duration: Float
	let thumbnail: URL

	public init(name: String, description: String, duration: Float, thumbnail: URL) {
		self.name = name
		self.description = description
		self.duration = duration
		self.thumbnail = thumbnail
	}
}

struct VideosState {
	var videos: [Video]
}

enum VideosAction {
	case onAppear
}

struct VideosEnvironment {
	private let apiService: VideosApiService

	public init(apiService: VideosApiService) { // KISS dependency injection
		self.apiService = apiService
	}
}

let videosReducer = Reducer<VideosState, VideosAction, VideosEnvironment> { state, action, environment in
	switch action {
	case .onAppear:
		// TODO
		return .none
	}
}
