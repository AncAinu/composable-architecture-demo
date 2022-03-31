import SwiftUI
import ComposableArchitecture

public typealias VideosViewStore = Store<VideosState, VideosAction>

public struct VideosView: View {
	let store: VideosViewStore

	public init(store: VideosViewStore) {
		self.store = store
	}

    public var body: some View {
		WithViewStore(store) { viewStore in
			List {
				ForEachStore(
					store.scope(
						state: \.videos,
						action: VideosAction.videoCell(id:action:)
					),
					content: VideoCell.init(store:))
			}
		}
    }
}

struct SwiftUIView_Previews: PreviewProvider {
	static var previews: some View {
		VideosView(store: VideosViewStore(
			initialState: VideosState.preview,
			reducer: videosReducer,
			environment: VideosEnvironment.preview)
		)
	}
}
