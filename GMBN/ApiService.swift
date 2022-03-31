import Foundation
import Videos
import ComposableArchitecture
import Alamofire

class ApiService: VideosApiService {
	private let url = "https://www.googleapis.com/youtube/v3/search"
	private let channelId = "UC_A--fhX5gea0i4UtpD99Gg"
	private let apiKey = "AIzaSyChqpP6YbxtMpZqYbP-ZPspcpMSMe-N8YI"

	private let dateFormatter = DateFormatter()
	private let decoder = JSONDecoder()

	init() {
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
		decoder.dateDecodingStrategy = .formatted(dateFormatter)
	}

	func requestVideos() -> Effect<[Video], Error> {
		return .future { promise in
			AF.request(self.url, parameters: [
				"key": self.apiKey,
				"channel_id": self.channelId,
				"maxResults": 50,
				"type": "video",
				"part": "snippet"
			])
			.validate()
			.responseDecodable(of: ApiResponseContainer.self, decoder: self.decoder) { apiResponse in
				print("<<< RequestVideos")
				switch apiResponse.result {
				case .success(let container):
					promise(.success(container.toVideos()))
				case .failure(let error):
					promise(.failure(error))
				}
			}
			.resume()
			print(">>> RequestVideos")
		}
	}
}

extension ApiResponseContainer {
	func toVideos() -> [Video] {
		return items.map { item in
			Video(name: item.snippet.title,
				  description: item.snippet.description,
				  date: item.snippet.publishedAt,
				  duration: 0, // I couldn't find where is video duration on the google api :(
				  thumbnail: item.snippet.thumbnails.default.url)
		}
	}
}

fileprivate struct ApiResponseContainer: Codable {
	let items: [ApiItem]
}

fileprivate struct ApiItem: Codable {
	let snippet: ApiItemSnippet
}

fileprivate struct ApiItemSnippet: Codable {
	let title: String
	let description: String
	let publishedAt: Date
	let thumbnails: ApiItemSnippetThumbnail
}

fileprivate struct ApiItemSnippetThumbnail: Codable {
	struct Details: Codable {
		let url: URL
	}
	let `default`: Details
}
