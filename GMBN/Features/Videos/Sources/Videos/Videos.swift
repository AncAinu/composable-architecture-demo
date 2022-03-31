import Foundation
import ComposableArchitecture

// Please note that the composable architecture is so light and composable in it's ability to do small modules, that file organisation inside modules is less relevant and allow for less care around that, but of course it can all be separated in files when it gets more complex, although the idea with TCA would be to do more modules

public struct Video: Identifiable, Equatable {
	public let id = UUID()
	let name: String
	let description: String
	let duration: TimeInterval
	let thumbnail: URL

	public init(name: String, description: String, duration: TimeInterval, thumbnail: URL) {
		self.name = name
		self.description = description
		self.duration = duration
		self.thumbnail = thumbnail
	}
}

public struct VideosState: Equatable {
	var videos: IdentifiedArrayOf<Video>

	public static var preview = Self(videos: [
		Video(name: "Test 1",
			  description: "Test 1 test 1",
			  duration: 65,
			  thumbnail: URL(string: "https://i.ytimg.com/vi/UtJjIeVyRk4/hqdefault.jpg")!),
		Video(name: "Test 2",
			  description: "Test 2 test 2",
			  duration: 65,
			  thumbnail: URL(string: "https://i.ytimg.com/vi/_8PPz5mo_Fg/hqdefault.jpg")!),
		Video(name: "Test 3",
			  description: "Test 3 test 3",
			  duration: 65,
			  thumbnail: URL(string: "https://i.ytimg.com/vi/iPuxdqopkqM/hqdefault.jpg")!)
	])
}

public enum VideosAction {
	case onAppear
	case videoCell(id: Video.ID, action: VideoCellAction)
}

public struct VideosEnvironment {
	private let apiService: VideosApiService

	public init(apiService: VideosApiService) { // KISS dependency injection
		self.apiService = apiService
	}

	public static var preview: Self {
		let service = VideosApiServiceMock()
		service._requestVideos = { .none }
		return Self(apiService: service)
	}
}

public typealias VideosReducer = Reducer<VideosState, VideosAction, VideosEnvironment>
public let videosReducer = VideosReducer.combine(
	videoCellReducer.forEach(
		state: \.videos,
		action: /VideosAction.videoCell(id:action:),
		environment: { _ in () } ),
	VideosReducer { state, action, environment in
		switch action {
		case .onAppear:
			// TODO
			return .none
		case .videoCell:
			// TODO
			return .none
		}
	}
)
