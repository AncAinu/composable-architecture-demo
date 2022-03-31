import Foundation
import ComposableArchitecture

// Please note that the composable architecture is so light and composable in it's ability to do small modules, that file organisation inside modules is less relevant and allow for less care around that, but of course it can all be separated in files when it gets more complex, although the idea with TCA would be to do more modules

public struct Video: Identifiable, Equatable {
	public let id = UUID()
	let name: String
	let description: String
	let date: Date
	let duration: TimeInterval
	let thumbnail: URL

	public init(name: String, description: String, date: Date, duration: TimeInterval, thumbnail: URL) {
		self.name = name
		self.description = description
		self.date = date
		self.duration = duration
		self.thumbnail = thumbnail
	}
}

public struct VideosState: Equatable {
	var videos: IdentifiedArrayOf<Video>

	public init(videos: IdentifiedArrayOf<Video> = IdentifiedArrayOf<Video>()) {
		self.videos = videos
	}
}

public enum VideosAction {
	case onAppear
	case videosResults(result: Result<[Video], Error>)
	case videoCell(id: Video.ID, action: VideoCellAction)
}

public struct VideosEnvironment {
	let apiService: VideosApiService
	let mainQueue: AnySchedulerOf<DispatchQueue>

	public init(apiService: VideosApiService,
				mainQueue: AnySchedulerOf<DispatchQueue> = .main) { // KISS dependency injection
		self.apiService = apiService
		self.mainQueue = mainQueue
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
			return environment.apiService.requestVideos()
				.catchToEffect()
				.map(VideosAction.videosResults)
				.receive(on: environment.mainQueue)
				.eraseToEffect()
			return .none
		case .videosResults(let result):
			switch result {
			case .success(let videos):
				state.videos = IdentifiedArray(uniqueElements: videos)
			case .failure(let error):
				print(error)
			}
			return .none
		case .videoCell:
			// TODO
			return .none
		}
	}
)
