//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import SwiftUI

public struct RootView: View {

    @ObservedObject
    private var viewModel: PlayListViewModel

    @State var currentlySelectedItemPlaying: Bool =  false

    // MARK: - Initializer

    public init() {
        self.viewModel = PlayListViewModel()
    }

    // MARK: - UI Body

    @MainActor
    public var body: some View {
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
    }

    // MARK: - Private Views

    @ViewBuilder
    private var nowPlayingView: some View {
        if case .selected(let item) = viewModel.selection {
            NowPlayingView(
                viewModel: item,
                isPlaying: Binding(
                    get: { item.isPlaying },
                    set: { value in item.isPlaying = value }
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
