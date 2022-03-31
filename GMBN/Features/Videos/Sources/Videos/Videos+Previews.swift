import Foundation

public extension VideosState {
	static var preview = Self(videos: [
		Video(name: "Test 1",
			  description: "Test 1 test 1",
			  date: Date(),
			  duration: 65,
			  thumbnail: URL(string: "https://i.ytimg.com/vi/UtJjIeVyRk4/hqdefault.jpg")!),
		Video(name: "Test 2",
			  description: "Test 2 test 2",
			  date: Date(),
			  duration: 65,
			  thumbnail: URL(string: "https://i.ytimg.com/vi/_8PPz5mo_Fg/hqdefault.jpg")!),
		Video(name: "Test 3",
			  description: "Test 3 test 3",
			  date: Date(),
			  duration: 65,
			  thumbnail: URL(string: "https://i.ytimg.com/vi/iPuxdqopkqM/hqdefault.jpg")!),
		Video(name: "Test 1",
			  description: "Test 1 test 1",
			  date: Date(),
			  duration: 65,
			  thumbnail: URL(string: "https://i.ytimg.com/vi/UtJjIeVyRk4/hqdefault.jpg")!),
		Video(name: "Test 2",
			  description: "Test 2 test 2",
			  date: Date(),
			  duration: 65,
			  thumbnail: URL(string: "https://i.ytimg.com/vi/_8PPz5mo_Fg/hqdefault.jpg")!),
		Video(name: "Test 3",
			  description: "Test 3 test 3",
			  date: Date(),
			  duration: 65,
			  thumbnail: URL(string: "https://i.ytimg.com/vi/iPuxdqopkqM/hqdefault.jpg")!),
		Video(name: "Test 1",
			  description: "Test 1 test 1",
			  date: Date(),
			  duration: 65,
			  thumbnail: URL(string: "https://i.ytimg.com/vi/UtJjIeVyRk4/hqdefault.jpg")!),
		Video(name: "Test 2",
			  description: "Test 2 test 2",
			  date: Date(),
			  duration: 65,
			  thumbnail: URL(string: "https://i.ytimg.com/vi/_8PPz5mo_Fg/hqdefault.jpg")!),
		Video(name: "Test 3",
			  description: "Test 3 test 3",
			  date: Date(),
			  duration: 65,
			  thumbnail: URL(string: "https://i.ytimg.com/vi/iPuxdqopkqM/hqdefault.jpg")!)
	])
}

public extension VideosEnvironment {
	static var preview: Self {
		let service = VideosApiServiceMock()
		service._requestVideos = { .none }
		return Self(apiService: service)
	}
}
