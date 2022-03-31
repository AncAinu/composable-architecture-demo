import SwiftUI
import Videos
import ComposableArchitecture

struct HomeView: View {
	var body: some View {
		NavigationView {
			VideosView(store: VideosViewStore(
				initialState: VideosState.preview,
				reducer: videosReducer,
				environment: VideosEnvironment.preview))
			.navigationTitle("GMBN")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
