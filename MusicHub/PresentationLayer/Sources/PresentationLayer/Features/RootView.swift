//
//  Created by Arinjoy Biswas on 24/11/2023.
//

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

    @ToolbarContentBuilder
    private var toolBarContent: some ToolbarContent {

        ToolbarItem(placement: .topBarLeading) {
            EmptyView()
        }

        ToolbarItem(placement: .principal) {
            if viewModel.isMockDataMode {
                HStack(spacing: 10) {
                    Text("DEMO mode") // TODO: move into viewModel
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)

                    Image(systemName: "cloud.snow") // TODO: move into viewModel
                        .resizable()
                        .scaledToFit()
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .frame(width: 30, height: 30)
                        .foregroundColor(.red)
                        .accessibilityHidden(true)
                }
                .accessibilityElement(children: .combine)
                .accessibilityAddTraits(.isHeader)
            } else {
                Text("Hee")
            }
        }
    }
}

#Preview {
    RootView()
}
