import Foundation

// Here we declare an api that we will want anyone using Videos feature to conform to

public protocol VideosApiService {
	func fetchVideos(completion: @escaping (Result<[Video], Error>) -> Void)
}
