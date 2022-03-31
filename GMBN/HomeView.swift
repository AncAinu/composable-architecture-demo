import SwiftUI
import Videos
import ComposableArchitecture

struct HomeView: View {
	var body: some View {
		NavigationView {
			VideosView(store: VideosViewStore(
				initialState: VideosState(),
				reducer: videosReducer,
				environment: VideosEnvironment(apiService: ApiService())
			))
			.navigationTitle("GMBN")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
