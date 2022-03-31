import SwiftUI
import ComposableArchitecture

// Here you can notice that we would easily be able to convert this file into a module, as it retains the composable structure of State, Action, Environment and Reducer that our main view has. That's the power of TCA

typealias VideoCellStore = Store<Video, VideoCellAction>
public enum VideoCellAction {}
let videoCellReducer = Reducer<Video, VideoCellAction, Void> { _, _, _ in
	return Effect.none
}

struct VideoCell: View {

	let store: VideoCellStore

    var body: some View {
		WithViewStore(store) { viewStore in
			HStack {
				AsyncImage(
					url: viewStore.thumbnail,
					content: { phase in
						switch phase {
						case .empty: Image(systemName: "hourglass")
						case .success(let image):
							image
								.resizable()
								.aspectRatio(contentMode: .fit)
						case .failure:
							Image(systemName: "icloud.slash.fill")
						}
					}
				)
				.frame(width: 100, height: 80)
				.foregroundColor(.white)
				.background(Color.gray)
				.clipped()
				Text(viewStore.name)
				Spacer()
				Text("\(viewStore.duration)")
			}
			.frame(height: 80)
		}
	}
}

struct VideoCell_Previews: PreviewProvider {
    static var previews: some View {
        VideoCell(store: VideoCellStore(
			initialState: VideosState.preview.videos[0],
			reducer: videoCellReducer,
			environment: ()))
		.previewLayout(.sizeThatFits)
    }
}
