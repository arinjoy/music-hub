import SwiftUI

public struct RootView: View {

    // MARK: - Properties

    @ObservedObject
    private var viewModel: PlayListViewModel

    // MARK: - Initializer

    public init() {
        self.viewModel = PlayListViewModel()
    }

    // MARK: - UI Body

    @MainActor
    public var body: some View {
        NavigationView {
            TabView {
                DevicePlayListView()
                    .tabItem {
                        Image(.tabbarIconBlockRooms)
                        Text("Rooms")
                    }

                nowPlayingView
                    .tabItem {
                        Image(.tabbarIconNowPlaying)
                        Text("Now Playing")
                    }

                SettingsView()
                    .tabItem {
                        Image(.tabbarIconSettings)
                        Text("Settings")
                    }
            }
            .environmentObject(viewModel)
            .navigationTitle(viewModel.isMockDataMode ? "Demo Mode" : "")
        }
    }

    // MARK: - Private Views

    @ViewBuilder
    private var nowPlayingView: some View {
        if case .selected(let item) = viewModel.selection {
            NowPlayingView(
                viewModel: item,
                isPlaying: Binding(
                    get: { item.isPlaying },
                    set: { value in
                        item.isPlaying = value
                    }
                )
            )
        } else {
            EmptyView()
        }
    }
}

#Preview {
    RootView()
}
