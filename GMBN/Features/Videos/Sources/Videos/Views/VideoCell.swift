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
				Text(viewStore.name)
				Spacer()
				Text("\(viewStore.duration)")
			}
			.frame(height: 44)
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
